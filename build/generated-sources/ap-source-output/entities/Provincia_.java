package entities;

import entities.Ccaa;
import entities.Municipio;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2026-10-20T23:59:49")
@StaticMetamodel(Provincia.class)
public class Provincia_ { 

    public static volatile SingularAttribute<Provincia, Short> id;
    public static volatile ListAttribute<Provincia, Municipio> municipioList;
    public static volatile SingularAttribute<Provincia, String> nombre;
    public static volatile SingularAttribute<Provincia, Ccaa> ccaa;

}