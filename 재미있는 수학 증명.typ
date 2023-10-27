#set text(font: "KoPubBatang_Pro")

#let to = $arrow.r$
#let sim = $tilde.eq$

#align(center, text(17pt)[
  *어떤 명제의 흥미로운 증명법*
])

#align(right, text(10pt)[
  한남대학교 수학과
  
  20172581 김남훈
])

= 1. 소개

=== 정리.
$T$ 를 위상공간, $p in T$ 라 하자. $T$ 의 $2$ 차 호모토피 군 $pi_2(T, p)$ 는 가환군이다.

=== 증명.
#figure(
    stack(
        dir: ltr,
        rect(width: 30pt, height: 60pt, align(horizon, $f$)),
        rect(width: 30pt, height: 60pt, align(horizon, $g$)),
        align(horizon, $space to space$),
        rect(width: 60pt, height: 60pt, fill: black,
            align(horizon, stack(
                    dir: ltr,
                    rect(width: 20pt, height: 40pt, fill: white, $f$),
                    $space$,
                    rect(width: 20pt, height: 40pt, fill: white, $g$)
                )
            )
        ),
        align(horizon, $space to space$),
        rect(width: 60pt, height: 60pt, fill: black,
            align(horizon, stack(
                    dir: ltr,
                    rect(width: 20pt, height: 40pt, fill:white, $g$),
                    $space$,
                    rect(width: 20pt, height: 40pt, fill:white, $f$)
                )
            )
        ),
        align(horizon, $space to space$),
        rect(width: 30pt, height: 60pt, align(horizon, $g$)),
        rect(width: 30pt, height: 60pt, align(horizon, $f$)),
        align(bottom, $space qed$)
    )
)

= 2. 기본 개념

위 증명에 대해 설명하기 전에, 먼저 이해하기 위해 필요한 내용들을 정리해보자.

=== 정의 1. 곱 공간(Product Space)과 곱 위상(Product Topology)
위상공간 $(T, tau_T)$ 와 $(S, tau_s)$ 가 주어졌으며 $f, g$ 가 각각 $T$ 에서 $S$ 로의 연속함수라고 하자. 그리고

$
    cal(B)_(T times S) &= { G times H bar G in tau_T and H in tau_H }\
    tau_(T times S) &= { union.big F bar F in cal(B) }
$

로 놓으면 $tau_(T times S)$ 는 $T times S$ 위의 위상이 되며, 이것을 곱 위상이라고 한다. $(T times S, tau_(T times S))$ 를 $T$ 와 $S$ 의 곱 공간이라 한다.

=== 정의 2. 호모토피(Homotopy)
위상공간 $T, S$ 에 대해 $f, g$ 가 $T$ 에서 $S$ 로의 연속함수라고 하자. 연속함수 $H : T times [0, 1] to S$ 가 다음을 만족하면 $H$ 를 $f$ 와 $g$ 사이의 *호모토피* 라 한다.

$
    H(t, 0) &= f(t)\
    H(t, 1) &= g(t)
$

$f$ 와 $g$ 사이의 호모토피가 존재한다면 $f$ 와 $g$ 는 *호모토픽(homotopic)* 하다고 하고 $f sim g$ 로 나타낸다.

=== 정리 1. 호모토피의 동치성
호모토피 관계 $sim$ 는 동치관계이다.

=== 증명.
$f, g, h$ 를 $T$ 에서 $S$ 로의 연속함수라고 하자.

 $H: T times [0, 1] to S$ 를 $h(t, r) = f(f)$ 로 정의하면 $h$ 는 $f$ 와 $f$ 사이의 호모토피이므로 $sim$ 는 반사적이다.

$H$ 가 $f$ 와 $g$ 사이의 호모토피라면, 함수 $H' : T times [0, 1] to S$ 를 $H'(t, r) = H(t, 1 - r)$ 로 정의하면 $H'$ 는 $g$ 와 $f$ 사이의 호모토피이다. 따라서 $sim$ 는 대칭적이다.

$H_1$ 이 $f$ 와 $g$ 사이의 호모토피, $H_2$ 이 $g$ 와 $h$ 사이의 호모토피라고 하자. $H : T times [0, 1] to S$ 을 다음과 같이 정의하자.

$
    H(t, r) = cases(
        H_1(t, 2r) &"if"& r lt.eq 1 / 2\
        H_2(t, 2r - 1) &"if"& r > 1 / 2
    )
$

그러면 $H$ 는 $f$ 와 $h$ 사이의 호모토피이다. 따라서, $sim$ 는 추이적이다.

$sim$ 는 반사적, 대칭적, 추이적이므로 동치관계이다.

=== 정의 3. 경로(Path)와 경로곱(Path Product)
위상공간 $T$ 와 $x, y in T$ 에 대해, 연속함수 $f : [0, 1] to T$ 가 $f(0) = x, f(1) = y$ 라면 $f$ 를 $x$ 에서 $y$ 로의 경로라고 한다. $x, y, z in T$ 이고 $f$ 가 $x$ 에서 $y$ 로의 경로, $g$ 가 $y$ 에서 $z$ 로의 경로라고 하자. 그리고 $h: [0, 1] to T$ 을 다음과 같이 정의하자.

$
    h(t) = cases(
        f(2t) &"if"& t lt.eq 1 / 2\
        g(2t - 1) &"if"& t > 1 / 2
    )
$

그러면 $h$ 는 $f$ 와 $g$ 의 경로곱이라 하고 $f star g$ 로 나타낸다.

=== 정리. 경로곱의 호모토피
위상공간 $T$ 와 $x, y, z in T$ 에 대해 $f_1, f_2$ 가 $x$ 에서 $y$ 로의 경로, $g_1, g_2$ 가 $y$ 에서 $z$ 로의 경로라고 하자. $f_1 sim f_2$ 이고, $g_1 sim g_2$ 이면면 $f_1 star g_1 sim f_2 star g_2$ 이다.

=== 증명.
$H_f$ 가 $f_1$ 과 $f_2$ 사이의 호모토피, $H_g$ 가 $g_1$ 과 $g_2$ 사이의 호모토피라 하고 $H : [0, 1] times [0, 1] to S$ 을 다음과 같이 정의하자.

$
    H(t, r) = cases(
        H_f(2t, r) &"if"& r lt.eq 1 / 2\
        H_g(2t - 1, r) &"if"& r > 1 / 2
    )
$

그러면 $H$ 는 $f_1 star g_1$ 과 $g_1 star g_2$ 사이의 호모토피이다.


=== 정리. 경로곱 연산의 결합 법칙
위상공간 $T$ 와 $x, y, z, w in T$ 에 대해 $f$ 가 $x$ 에서 $y$ 로의 경로, $g$ 가 $y$ 에서 $z$ 로의 경로, $h$ 가 $z$ 에서 $w$ 로의 경로라고 하자. 그러면 $f star (g star h) sim (f star g) star h$ 이다.

=== 증명.
연속함수 $H : [0, 1] times [0, 1] to T$ 를 다음과 같이 정의하자.

$
    H(t, r) = cases(
        f[2 t - 4 t r] &"if"& t - 4r gt.eq - 1\
        g[4 t - r + 1 / 4] &"if"& -2 < t - 4r < - 1\
        h[1 / 4 t - 1 / 4 r] &"if"& -2 < t - 4r < - 1
    )
$

함수의 값의 변화를 그림으로 직관적으로 살펴보면 아래와 같다.

#figure(
    stack(dir: ltr,
        align(horizon, $H : space$),
        stack(dir:ttb,
            place(dx: -65pt, dy: -11pt, $x$),
            place(dx: -0pt, dy: -11pt, $y$),
            place(dx: 30pt, dy: -11pt, $z$),
            place(dx: 57.5pt, dy: -11pt, $w$),
            square(size: 120pt, stroke: black,
                stack(
                    place(dx: 57.5pt, dy: -5pt, line(end: ( -30pt, 120pt), stroke : (dash: "dotted"))),
                    place(dx: 87.5pt, dy: -5pt, line(end: ( -30pt, 120pt), stroke : (dash: "dotted"))),
                    place(dx: 15pt, dy: 50pt, $f$),
                    place(dx: 55pt, dy: 50pt, $g$),
                    place(dx: 90pt, dy: 50pt, $h$),
                    place(dx: -32.5pt, dy: -5pt, $(0, 0)$),
                    place(dx: 117.5pt, dy: -5pt, $(1, 0)$),
                    place(dx: -32.5pt, dy: 105pt, $(0, 1)$),
                    place(dx: 117.5pt, dy: 105pt, $(1, 1)$)
                )
            ),
            place(dx: -65pt, dy: 1pt, $x$),
            place(dx: -30pt, dy: 1pt, $y$),
            place(dx: 0pt, dy: 1pt, $z$),
            place(dx: 57.5pt, dy: 1pt, $w$),
        )
    )
)

그림에서 알 수 있듯, $H(t, 0) = [f star (g star h)](t)$ 이고 $H(t, 1) = [(f star g) star h](t)$ 이다. 따라서, $H$ 는 $f star (g star h)$ 와 $(f star g) star h$ 사이의 호모토피이다.

=== 정리 4. 폐경로의 성질
이제 $T$ 를 위상공간, $x in T$ 이라 하자. $e$ 를 모든 $t in [0, 1]$ 에 대해 $e(t) = x$ $x$ 에서 $x$ 로의 경로라 하고, $x$ 에서 $x$ 로의 경로 $f$ 에 대해 $f'$ 를 모든 $t in [0, 1]$ 에 대해 $f'(t) = f(1 - t)$ 인 $x$ 에서 $x$ 로의 경로라 하자.

그러면 $x$ 에서 $x$ 로의 임의의 경로 $f$ 에 대해 다음이 성립한다.

+ $f star e sim e star f sim f$
+ $f star f' sim f' star f sim e$

=== 증명.
$H_1, H_2$ 를 다음과 같이 정의하자.