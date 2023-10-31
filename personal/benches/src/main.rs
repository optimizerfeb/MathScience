use bencher::{Bencher, benchmark_group, benchmark_main};

union U {
    f: f32,
    i: i32,
}

fn a(bench: &mut Bencher) {
    bench.iter(|| {
        let mut x: f32 = 512.0;
        for _ in 0..1000000 {
            x.exp();
        }
    })
}

fn b(bench: &mut Bencher) {
    bench.iter(|| {
        let mut x: f32 = 512.0;
        for _ in 0..1000000 {
            unsafe {
                let mut u = U { f: x };
                u.i = ((u.f + 127.0 - 0.043) as i32).overflowing_shl(23).0;

                let y = u.f;
            }
        }
    })
}

benchmark_group!(benches, a, b);
benchmark_main!(benches);

