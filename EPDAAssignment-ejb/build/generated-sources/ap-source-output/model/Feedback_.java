package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2021-03-16T15:22:02")
@StaticMetamodel(Feedback.class)
public class Feedback_ { 

    public static volatile SingularAttribute<Feedback, String> feedback;
    public static volatile SingularAttribute<Feedback, Integer> rating;
    public static volatile SingularAttribute<Feedback, String> id;
    public static volatile SingularAttribute<Feedback, String> bookingID;

}