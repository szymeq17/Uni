public class Main {
    public static void main(String[] args) {
        // Zadanie 3
        double a = 0.0;
        double b = 1.0;
        double a0 = a;
        double b0 = b;
        double m;
        for(int i=0; i<5; i++) {
            m = (a+b)/2.0;
            System.out.println(m);
            System.out.println("Wartość błędu dla n = " + (i+1) + ": " + Math.abs(m-0.49));
            System.out.println("Szacowany błąd dla n = " + (i+1) + ": " + Math.pow(2.0, -i-1)*(b0-a0));
            if(Functions.f(m)<0) {
                a = m;
            }
            else {
                b = m;
            }
        }
        // Zadanie 4
//        double a = -1.0;
//        double b = -0.5;
//        double m = 0;
//
//        for(int i=0; i<15; i++) {
//            m = (a+b)/2.0;
//            if(-Functions.g(m)<0) {
//                a = m;
//            }
//            else {
//                b = m;
//            }
//        }
//        System.out.println("Pierwsze miejsce zerowe to " + m);
//
//        a = 0.0;
//        b = 0.5;
//        for(int i=0; i<15; i++) {
//            m = (a+b)/2.0;
//            if(Functions.g(m)<0) {
//                a = m;
//            }
//            else {
//                b = m;
//            }
//        }
//        System.out.println("Drugie miejsce zerowe to " + m);
        // Zadanie 8;
//        double x0 = 1.25;
//        double r = 10;
//        for(int i = 0; i < 10; i++) {
//            x0 = x0 - (r * (6 * x0 - 6))/6;
//        }
//        System.out.println(x0);
   }
}
