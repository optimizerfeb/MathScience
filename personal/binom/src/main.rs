use std::f32::consts::E;

const lne32: f32 = 1.44269504089;
const mult32:f32 = 8388608.0;
const adder32: f32 = 126.9427;

const lne64: f64 = 1.44269504089;
const mult64:f64 = 4503599627370496.0;
const adder64: f64 = 1022.9427;


fn fast_exp32(x: f32) -> f32 {

    union U {
        f: f32,
        i: i32,
    }
    
    unsafe {
        let mut u = U { f: x };
        u.f = (u.f * lne32 + adder32) * mult32;
        u.i = u.f as i32;

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
        u.f = u.f * lne64 + adder64;
        u.f = u.f * mult64;
        u.i = u.f as i64;

        u.f
    }

}

fn main() {
    let mut x = 1.0_f64;
    let mut spread = 0.0;
    let mut gusigi = 1;

    let (mut min, mut max) = (f64::MAX, 0.0_f64);
    let (mut minval, mut maxval) = (0.0_f64, 0.0_f64);
    for ind in 0..7050 {
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
            println!("e^{:.0} : trad = {:.8e}, fast = {:.8e}, error = {:.8e}", x, a, b, a / b);
            gusigi += 1000;
        }

        x += 0.1;
    }

    spread = spread / 7050.0;

    let distrib = spread.sqrt();

    println!("Deviation : {:.8}, Min_error : {:.8} at {:.0}, Max_error : {:.8} at {:.0}", distrib, min, minval, max, maxval);
}