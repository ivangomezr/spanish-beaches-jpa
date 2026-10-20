/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author paco
 */
public class JPAUtil {
    private static final EntityManagerFactory emf;
    static {
        try {
            Class.forName("org.h2.Driver");
            try (java.sql.Connection con = java.sql.DriverManager.getConnection(
                    "jdbc:h2:mem:playas;DB_CLOSE_DELAY=-1;MODE=Oracle", "sa", "");
                 java.sql.Statement st = con.createStatement()) {
                st.execute("RUNSCRIPT FROM 'classpath:/db/playas.sql' CHARSET 'UTF-8'");
            }
            emf = Persistence.createEntityManagerFactory("PlayasJPAPU");
        } catch (Exception e) {
            throw new ExceptionInInitializerError(e);
        }
    }
    public static EntityManagerFactory getEntityManagerFactory(){
        return emf;
    }
}

