package abmc;


import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class Alumno {
    private String nombre;
    private int edad;

    public Alumno() {}

    public Alumno(String nombre, int edad) {
        this.nombre = nombre;
        this.edad = edad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    @Override
    public String toString() {
        return nombre + " - " + edad;
    }
    
    //metodos de acceso JDBC
    public static void consultarTodos() throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        //obtengo la conexion
        Connection unaConexion = Conexion.obtenerConexion();
        
        //armo la consulta
        String unaConsulta = "select * from alumnos";
        
        //armo la sentencia
        Statement unaSentencia = unaConexion.createStatement();
        
        //ejecuto la query y guardo el resultado
        ResultSet unResultado = unaSentencia.executeQuery(unaConsulta);
        
        //itero la sentencia y muestro 
        while (unResultado.next()) {
            System.out.println("Nombre: "+unResultado.getString("nombre"));
            System.out.println("Edad: "+unResultado.getInt("edad"));
            System.out.println("---------------------------------");
        }
        
        //cierro
        unResultado.close();
        unaConexion.close();
        unaSentencia.close();
    }   
    
}
