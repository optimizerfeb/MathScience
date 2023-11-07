// But not faster than the standard library's exp function, because that is one-line assembly.

use std::f32::consts::E;

const mult32:f32 = 12102203.161561485;
const adder32: f32 = 1064872507.1615615;

const mult64:f64 = 6497320848556798.0;
const adder64: f64 = 4606924340207518000.0;


fn fast_exp32(x: f32) -> f32 {

    union U {
        f: f32,
        i: i32,
    }
    
    unsafe {
        let mut u = U { f: x };
        u.i = u.f.mul_add(mult32, adder32) as i32;
        u.f
    }

}

fn fast_exp64(x: f64) -> f64 {

    union U {
        f: f64,
        i: i64,
    }
    
    unsafe {
        let mut u = U { f: x };
        u.i = u.f.mul_add(mult64, adder64) as i64;
        u.f
    }

}

fn main() {
    let mut x = 1.0_f64;
    let mut spread = 0.0;
    let mut gusigi = 0;

    let (mut min, mut max) = (f64::MAX, 0.0_f64);
    let (mut minval, mut maxval) = (0.0_f64, 0.0_f64);
    for ind in 0..=700000000 {
        let a = x.exp();
        let b = fast_exp64(x);
        let error = a / b - 1.0;

        if error < min {
            min = error;
            minval = x;
        }

        if error > max {
            max = error;
            maxval = x;
        }

        spread += error * error;

        if ind == gusigi {
            println!("e^{:.0} : trad = {:.4e}, fast = {:.4e}, ratio = {:.6}", x, a, b, a / b);
            gusigi += 100000000;
        }

        x += 0.000001;
    }

    spread = spread / 700000000.0;

    let distrib = spread.sqrt();

    println!("Deviation : {:.6}  \nMin_error : {:.6} at {:.6} \nMax_error : {:.6} at {:.6}", distrib, min, minval, max, maxval);
}