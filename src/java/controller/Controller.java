package controller;
import entities.Ccaa;
import entities.Images;
import entities.Municipio;
import entities.Playa;
import entities.Provincia;
import entities.Punto;
import entities.Usuario;
import java.awt.Image;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import javax.persistence.RollbackException;
import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import util.JPAUtil;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        /*
		 * Crear el singleton con
         */
        
        List<Images> images;
        List<Playa> playas;
        List<Ccaa> comunidades;
        List<Provincia> provincias;
        List<Municipio> municipios;
        long mediaPuntos;
        
        Query q;
        Query qAVGPuntos;
        Usuario usuario = null;
        Punto punto = null;
        EntityTransaction t;

        EntityManager em = (EntityManager) session.getAttribute("em");
        if (em == null) {
            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            session.setAttribute("em", em);
        }

        String op = request.getParameter("op");
        RequestDispatcher dispatcher;
        if (op.equals("inicio")) {
            q = em.createNamedQuery("Ccaa.findAll");
            comunidades = q.getResultList();
            session.setAttribute("comunidades", comunidades);
            
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
       
        } else if(op.equals("vacomunidad")){
            String idcomunidad = request.getParameter("selectcomunidad");
            session.setAttribute("comunidad", idcomunidad);
            Ccaa comunidad = em.find(Ccaa.class, Short.valueOf(idcomunidad));
            provincias = comunidad.getProvinciaList();
            session.setAttribute("provincias", provincias);
            
            session.removeAttribute("provincia");
            session.removeAttribute("municipio");
            session.removeAttribute("playas");
            
            request.getRequestDispatcher("home.jsp").forward(request, response);
        
        } else if(op.equals("vaprovincia")){
            String idprovincia = request.getParameter("selectprovincia");
            session.setAttribute("provincia", idprovincia);
            Provincia provincia = em.find(Provincia.class, Short.valueOf(idprovincia));
            municipios = provincia.getMunicipioList();
            session.setAttribute("municipios", municipios);
            
            request.getRequestDispatcher("home.jsp").forward(request, response);
            
        } else if(op.equals("vamunicipio")){
            String idmunicipio = request.getParameter("selectmunicipio");
            session.setAttribute("municipio", idmunicipio);
            Municipio municipio = em.find(Municipio.class, Integer.parseInt(idmunicipio));
            playas = municipio.getPlayaList();
            session.setAttribute("playas", playas);
            
            request.getRequestDispatcher("home.jsp").forward(request, response);
        
        } else if(op.equals("login")) {
            String nick = request.getParameter("nick");
            String password = request.getParameter("pass");
            if (nick == null || nick.trim().isEmpty() || password == null || password.isEmpty()) {
                session.setAttribute("msg", "Error: tienes campos sin rellenar");
            } else {
                List<Usuario> encontrados = em.createNamedQuery("Usuario.findByNick")
                        .setParameter("nick", nick.trim())
                        .getResultList();
                if (encontrados.isEmpty()) { // No existe: lo registramos
                    usuario = new Usuario();
                    usuario.setNick(nick.trim());
                    usuario.setPass(password);
                    t = em.getTransaction();
                    t.begin();
                    em.persist(usuario);
                    t.commit();
                    session.setAttribute("user", usuario);
                    session.setAttribute("msg", "Usuario registrado. Bienvenido " + usuario.getNick());
                } else if (encontrados.get(0).getPass().equals(password)) {
                    session.setAttribute("user", encontrados.get(0));
                } else {
                    session.setAttribute("msg", "Contraseña incorrecta");
                }
            }
            request.getRequestDispatcher("home.jsp").forward(request, response);
            
        } else if(op.equals("logout")) {
            session.removeAttribute("user");
            session.setAttribute("msg", "Logout satisfactorio");
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        
        } else if(op.equals("detail")) {
            String idplaya = request.getParameter("playa");
            Playa playa = em.find(Playa.class, Integer.parseInt(idplaya));
            session.setAttribute("playa", playa);
                        
            Usuario user = (Usuario)session.getAttribute("user");
            session.setAttribute("user", user);
            try {
                qAVGPuntos = em.createQuery("Select avg(p.puntos) from Punto p where p.playa.id = :idplaya").setParameter("idplaya", Integer.parseInt(idplaya));
                mediaPuntos = Math.round(((Number)qAVGPuntos.getSingleResult()).doubleValue());
            } catch (NullPointerException e) {
                mediaPuntos = 0;
            }
            session.setAttribute("mediaPuntos", mediaPuntos);
            
            request.getRequestDispatcher("detail.jsp").forward(request, response);
            
        } else if(op.equals("vapuntos")) {
            Short puntos = Short.parseShort(request.getParameter("puntos"));
            Short idusuario = Short.parseShort(request.getParameter("user"));
            Usuario usuarioPuntos = em.find(Usuario.class, idusuario);
            Integer idplaya = Integer.parseInt(request.getParameter("playa"));
            Playa playa = em.find(Playa.class, idplaya);
            punto = new Punto();
            punto.setPuntos(puntos);
            punto.setUsuario(usuarioPuntos);
            punto.setPlaya(playa);
            
            t = em.getTransaction();
            t.begin();
            em.persist(punto);
            t.commit();
            
            qAVGPuntos = em.createQuery("Select avg(p.puntos) from Punto p where p.playa.id = :idplaya").setParameter("idplaya", idplaya);
            mediaPuntos = Math.round(((Number)qAVGPuntos.getSingleResult()).doubleValue());
            session.setAttribute("mediaPuntos", mediaPuntos);
            
            request.getRequestDispatcher("detail.jsp").forward(request, response);
            
        } else if(op.equals("puntuacion")) {
            int idplaya = Integer.parseInt(request.getParameter("playa"));
            q = em.createQuery("Select count(p) From Punto p Where p.playa.id="+idplaya+" group by p.puntos");
            List<Short> puntuacion = q.getResultList();
            session.setAttribute("puntuacion", puntuacion);
            
            request.getRequestDispatcher("puntuacion.jsp").forward(request, response);
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}

