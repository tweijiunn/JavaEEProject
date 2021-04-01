package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2021-03-16T15:22:02")
@StaticMetamodel(Booking.class)
public class Booking_ { 

    public static volatile SingularAttribute<Booking, Date> date;
    public static volatile SingularAttribute<Booking, String> hallID;
    public static volatile SingularAttribute<Booking, String> id;
    public static volatile SingularAttribute<Booking, String> userID;
    public static volatile SingularAttribute<Booking, Integer> status;

}