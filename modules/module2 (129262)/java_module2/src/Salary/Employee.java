package Salary;

public class Employee extends Manager		     //inheritence
{
double sal=2000;

public double calEmployeeSalary()	             //method definition to calculate employee salary
	{	
	return sal;
	}

public static void main(String[] args)	             //main method
	{
	Employee emp=new Employee();		     //Creating object to this class
	double mgr_sal=emp.calManagerSalary();
	double emp_sal=emp.calEmployeeSalary();
	System.out.println("the salary of the manager is:"+mgr_sal);
	System.out.println("the salary of the employee is:"+emp_sal);
	
	}

}
