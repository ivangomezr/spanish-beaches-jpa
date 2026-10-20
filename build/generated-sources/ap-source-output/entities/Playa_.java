package entities;

import entities.Images;
import entities.Municipio;
import entities.Punto;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2026-10-20T23:59:49")
@StaticMetamodel(Playa.class)
public class Playa_ { 

    public static volatile SingularAttribute<Playa, String> descripcion;
    public static volatile SingularAttribute<Playa, Municipio> municipio;
    public static volatile ListAttribute<Playa, Punto> puntoList;
    public static volatile SingularAttribute<Playa, Integer> id;
    public static volatile SingularAttribute<Playa, String> nombre;
    public static volatile ListAttribute<Playa, Images> imagesList;

}