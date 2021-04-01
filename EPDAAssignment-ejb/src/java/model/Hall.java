/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 *
 * @author tweij
 */
@Entity
public class Hall implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private String id;
    private String hallName;
    private String hallDescription;
    private Double hallDailyPrice;
    private String hallSize;
    private int status;

    public Hall() {
    }

    
    public Hall( String hallName, String hallDescription, Double hallDailyPrice, String hallSize,int status) {
        this.hallName = hallName;
        this.hallDescription = hallDescription;
        this.hallDailyPrice = hallDailyPrice;
        this.hallSize = hallSize;
        this.status = status;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getHallDescription() {
        return hallDescription;
    }

    public void setHallDescription(String hallDescription) {
        this.hallDescription = hallDescription;
    }

    public String getHallSize() {
        return hallSize;
    }

    public void setHallSize(String hallSize) {
        this.hallSize = hallSize;
    }
    
    

    public String getHallName() {
        return hallName;
    }

    public void setHallName(String hallName) {
        this.hallName = hallName;
    }

    public Double getHallDailyPrice() {
        return hallDailyPrice;
    }

    public void setHallDailyPrice(Double hallDailyPrice) {
        this.hallDailyPrice = hallDailyPrice;
    }
    
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    
    

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Hall)) {
            return false;
        }
        Hall other = (Hall) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Hall[ id=" + id + " ]";
    }
    
}
