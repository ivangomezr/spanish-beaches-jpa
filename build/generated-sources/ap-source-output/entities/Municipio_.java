package entities;

import entities.Playa;
import entities.Provincia;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2026-10-20T23:59:49")
@StaticMetamodel(Municipio.class)
public class Municipio_ { 

    public static volatile ListAttribute<Municipio, Playa> playaList;
    public static volatile SingularAttribute<Municipio, Integer> id;
    public static volatile SingularAttribute<Municipio, Provincia> provincia;
    public static volatile SingularAttribute<Municipio, String> nombre;

}