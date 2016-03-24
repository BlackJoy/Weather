package dao;

import java.io.Serializable;
import java.sql.Date;
public class barBean {
    private String name;
    private int num;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public int getNum() {
        return num;
    }
    public void setNum(int num) {
        this.num = num;
    }
    
    public barBean(){
    	
    	
    }
    
	public barBean(String name, int num) {
		super();
		this.name = name;
		this.num = num;
	}
    
    
    
}
