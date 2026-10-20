package entities;

import entities.Playa;
import entities.Usuario;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2026-10-20T23:59:49")
@StaticMetamodel(Punto.class)
public class Punto_ { 

    public static volatile SingularAttribute<Punto, Playa> playa;
    public static volatile SingularAttribute<Punto, Usuario> usuario;
    public static volatile SingularAttribute<Punto, Integer> id;
    public static volatile SingularAttribute<Punto, Short> puntos;

}