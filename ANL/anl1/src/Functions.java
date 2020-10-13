public class Functions {
    public static float power(float a, int b) {
       int k;
       boolean minus = false;
       float start = 1;
       if(b<0) {
            minus = true;
            k = -b;
       }
       else {
           k = b;
       }
       for(int i=0; i<k; i++) {
           if(minus) {
               start = start/a;
           }
           else {
               start = start*a;
           }
       }
       return start;
   }
}
