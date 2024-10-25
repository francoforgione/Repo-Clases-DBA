package abmc;


import java.sql.SQLException;


public class Test {
    public static void main(String[] args) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException, InterruptedException {
        System.out.println("Consultar Todos");
        Alumno.consultarTodos();
        
    }
}
