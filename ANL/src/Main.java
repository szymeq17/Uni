public class Main {
    public static void main(String[] args) {
        double x = Math.pow(0.001, 11);
        double res1, res2;
        res1 = 4040.0 * (Math.sqrt(x+1) - 1) / x;
        res2 = 4040.0 / (Math.sqrt(x + 1) + 1);
        System.out.println("Wynik dla starego wzoru: " + res1);
        System.out.println("Wynik dla nowego wzoru: " + res2);
    }
}
