
public class Main {

    public static void main(String[] args) {
        // Zadanie 1
//        double x = Math.pow(0.001, 3);
//        double y = 1;
//        for(int i=0; i<11; i++) {
//            x = x * y;
//        }
//        double result = 4040 * (Math.sqrt(x + 1) - 1)/x;
//        System.out.println(result);

        // Zadanie 2
        // float (pojedyncza precyzja)
//        float x;
//        for(int i=11; i<=20; i++) {
//            x = Functions.power(10.0f, -i);
//            System.out.println("Dla i = "+i+" "+ 12120 * ((x - Math.sin(x))/Functions.power(x, 3)));
//        }
        // double
//        double x;
//        for(int i=11; i<=20; i++) {
//            x = Math.pow(10.0, -i);
//            System.out.println("Dla i = "+i+" "+ 12120 * ((x - Math.sin(x))/Math.pow(x, 3)));
//        }
        // Zadanie 3
        double[] y = new double[51];
        y[0] = 1;
        y[1] = -1 / 7.0;
        for (int i = 2; i <= 50; i++) {
            y[i] = 1 / 7.0 * (69 * y[i - 1] + 10 * y[i - 2]);
            System.out.println("y" + i + " = " + y[i]);
        }

        // Zadanie 4
//        double[] res = new double[21];
//        res[0] = Math.log(2021.0/2020.0);
//        for(int i=1; i<=20; i++) {
//            res[i] = 1.0/i - 2020 * res[i-1];
//            System.out.println("I"+i+" = "+res[i]);
//            System.out.println("I"+i+" - 2020*I"+ (i-1) + " = " + (res[i]+2020*res[i-1]));
//        }


        // Zadanie 5
//        double pi = 0;
//        for (int k = 0; k <= 20001  ; k++) {
//            pi += Math.pow(-1, k) / (2 * k + 1);
//        }
//        pi = 4 * pi;
//        System.out.println(pi);
//        System.out.println("PI = "+Math.PI);


    }
}

