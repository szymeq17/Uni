public class Functions {
    public static double fact(double n) {
        double res = 1;
        for(int i = 1; i<=n; i++) {
            res = res * i;
        }
        return res;
    }
}
