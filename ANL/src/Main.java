import java.sql.SQLOutput;

public class Main {
    public static void main(String[] args) {
        // Zadanie 7
        // a
        double x = 100000;
        System.out.println("Pierwszy wzór: " + (Math.pow(x, 3) - Math.sqrt(Math.pow(x, 6) + 2020.0)));
        System.out.println("Drugi wzór: " + (-2020.0 / (Math.pow(x, 3) + Math.sqrt(Math.pow(x, 6) + 2020.0))));
        // b
//        double x = 0.00001;
//        System.out.println("Pierwszy wzór: " + (Math.pow(x, -4) * (Math.cos(x) - 1.0 + Math.pow(x, 2)/2.0)));
//        double result = 0.0;
//        for(int i=0; i<16; i++) {
//            if(i%2==0) {
//                result += Math.pow(x, i * 2)/Functions.fact(2*i + 4.0);
//            }
//            else {
//                result -= Math.pow(x, i * 2)/Functions.fact(2*i + 4.0);
//            }
//        }
//        System.out.println("Drugi wzór: " + result);
        // c
//        double x = Math.pow(5.0, 6);
//        System.out.println("Pierwszy wzór: " + (Math.log(x)/Math.log(5) - 6));
//        System.out.println("Pierwszy wzór: " + (Math.log(x/Math.pow(5, 6))/Math.log(5)));
//    }
}
