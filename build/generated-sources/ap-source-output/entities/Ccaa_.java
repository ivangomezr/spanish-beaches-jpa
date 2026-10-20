package entities;

import entities.Provincia;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2026-10-20T23:59:49")
@StaticMetamodel(Ccaa.class)
public class Ccaa_ { 

    public static volatile SingularAttribute<Ccaa, Short> id;
    public static volatile SingularAttribute<Ccaa, String> nombre;
    public static volatile ListAttribute<Ccaa, Provincia> provinciaList;

}