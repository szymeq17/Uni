public class Functions {
    public static double f(double x) {
        return x - 0.49;
    }
    public static double g(double x) {
        return x*x - 2 * Math.cos(3*x + 1);
    }
    public static double h(double x, double a){
        return (1/(x*x)) - a;
    }
    public static void znajdzPierwiastekA(double a, double x) {
        int i = 0;
        while (Functions.h(x, a) != 0) {
            x = 1.0 / 2.0 * (3 - a * (x * x)) * x;
            i += 1;
        }
        System.out.println("Ilość iteracji: " + i);
        System.out.println("Wynik: " + x);
    }

    public static void odwrotnosc(double r, double x){
        for(int i=0; i<10; i++) {
            x = x * (2 - x*r);
            System.out.println(i + " iteracji: " + x);
        }
        }
}
