#set text(font: "Noto Serif KR")

#align(center, text(17pt)[
  *셀룰러 오토마타를 이용한 게임 컨텐츠 자동생성*
])

#align(right, text(10pt)[
  한남대학교 수학과
  
  20172581 김남훈
])

= 1. 게임 컨텐츠 자동생성
게임 속에는 맵, NPC, 퀘스트, 던전 등 다양한 컨텐츠가 존재한다. 이러한 컨텐츠들은 개발자가 직접 만들기도 하지만, 때로는 자동생성을 통해 만들기도 한다. 자동생성으로 만들어진 컨텐츠는 단조로운 패턴 등으로 비판받기도 하지만, 매 플레이시마다 다른 맵을 제공하는 게임에는 자동생성이 사실상 필수라고 할 수 있다.

#figure(
  image("images/Minecraft.png"),
  caption: [마인크래프트의 모든 맵은 자동생성을 통해 만들어진다.]
)

= 2. 셀룰러 오토마타
*셀룰러 오토마타* 는 게임 컨텐츠, 그중 맵을 자동생성하는데 가장 널리 이용된다. 셀룰러 오토마타를 이용한 맵 제작 방법에 대해 알아보기 전에, 먼저 셀룰러 오토마타의 정의를 알아보자.

*오토마타* 는 상태의 집합 $Q$ 와 입력의 집합 $Sigma$, 입력에 따른 상태 변화를 나타내는 함수 $delta$
$ delta : Q times Sigma arrow.r Q $
와 처음 상태 $q_0$, 최종 상태 $q_omega$ 로 이루어진 수학적 구조 $cal(A) = (Q, Sigma, delta, q_0, q_omega)$ 이다.

*셀룰러 오토마타* 는 주변의 다른 오토마타들의 상태를 입력으로 받는 오토마타이다. 셀룰러 오토마타의 대표적인 예시로, *콘웨이의 생명 게임* 이 있다.

#figure(
    image("images/Game of Life.svg", width: 90%),
    caption: [콘웨이의 생명 게임\ 각각의 격자가 셀룰러 오토마타이다.]
)

콘웨이의 생명 게임은 다음과 같은 규칙으로 진행된다. 주변에 존재하는 상태 $1$ 의 갯수를 입력이라 할 때

#figure(
  
  table(
    columns: (auto, auto, auto, auto, auto),
    $delta$, [$0 ~ 1$ 개], [$2$ 개], [$3$ 개], [$4 ~ 8$ 개],
    $1$, $0$, $1$, $1$, $0$,
    $0$, $0$, $0$, $1$, $0$
  ),
  caption: [생명 게임의 규칙]
)

와 같으며, 실제로 그림에서는 표와 같은 규칙으로 각 격자의 상태가 변화함을 확인할 수 있다.

== 엄밀한 정의
+ $A, B$ 가 집합일 때, $A^B$ 는 $B$ 에서 $A$ 로의 모든 함수의 집합을 나타낸다.
+ $A, B, C$ 가 집합이고 $A subset B$ 이며 $f : A arrow.r C$ 라 할 때, $f bar_B$ 는 모든 $x in B$ 에 대해
  $
  f(x) = f bar_B (x)
  $
  인 $B$ 에서 $C$ 로의 함수를 나타낸다.
+ $G$ 가 군, $A$ 가 집합이고 $sigma : G arrow.r A$ 이며 $g in G$ 일 때, $g sigma$ 는, 모든 $h$ 에 대해
  $
  g sigma(h) = sigma(g^(-1) h)
  $
  인 $G$ 에서 $A$ 로의 함수를 나타낸다.

$G$ 를 군, $S$ 를 $G$ 의 어떤 유한 부분집합, $Sigma$ 를 오토마타가 가질 수 있는 상태의 집합이라 하자. 그리고 $mu$ 를 $Sigma^S$ 에서 $Sigma$ 로의 임의의 함수(함수를 값으로 받는 함수)라 하자. 이제 $tau$ 를, 다음 성질을 만족하는 $Sigma^G$ 에서 $Sigma^G$ 로의 함수라 하면, $cal(C) = (G, Sigma, tau)$ 를 군 $G$ 와 상태 $Sigma$ 위의 *셀룰러 오토마타* 라고 한다.
$
forall x in Sigma^G, forall g in G\
[tau(x)](g) = mu[(g^(-1)x) bar_S]
$

= 3. 셀룰러 오토마타를 이용한 게임 컨텐츠 자동생성
셀룰러 오토마타를 이용해 게임의 맵을 자동생성하는 두 가지 방법을 알아보자.

=== 다수의 섬으로 이루어진 지형 자동생성
첫번째로, 셀룰러 오토마타를 이용해 랜덤 노이즈로부터 여러개의 섬이 존재하는 맵을 생성하는 방법이다.

#figure(
  image("images/Islands.svg"),
  caption: [랜덤 노이즈로부터 섬 생성]
)

여기에서는, 각 픽셀은 주변 여덟 픽셀의 색깔을 입력으로 받아, 흰 픽셀이 4개 이상이면 자신의 색을 흰색으로, 3개 이하이면 자신의 색깔을 검정색으로 변경한다. 이것을 11회 반복하여 랜덤 노이즈로부터 섬을 생성할 수 있다.

=== WFC 알고리즘
WFC(Wave Function Collapse) 알고리즘은 비교적 최근인 2016년 발표된 알고리즘으로, 셀룰러 오토마타를 이용해 보다 복잡하고 일관성 있는 맵을 생성하는 알고리즘이다. Wave Function Collapse 라는 이름은 양자역학적 현상인 *파동함수 붕괴* 에서 따온 이름으로, 관측 전까지 파동함수의 형태로 확률로서만 존재하던 각 입자의 상태가 관측 순간 파동함수가 붕괴하여 확정되는 양자역학의 법칙과 유사하여 지어진 이름이다.

셀룰러 오토마타가 가질 수 있는 상태, 즉 타일의 집합 $S$ 와 미리 상태가 정해진 몇 개의 타일이 주어졌을 때, WFC 알고리즘은 상태가 정해진 타일의 주변 좌표들을 *관측* 한다. 주위에 어떤 타일이 있는지에 따라 각 좌표의 타일의 확률 분포가 정해지며, 각 좌표를 관측할 때마다 확률 분포에 따라 각 위치의 타일이 *확정* 된다. 이러한 과정은 맵 위의 모든 좌표에서 타일이 확정될때까지 반복된다.

각 오토마타가 $0$ 과 $1$ 만을 상태로 갖는 위의 방법과 달리, WFC 알고리즘은 다양한 상태를 가질 수 있는 오토마타를 사용하며, 타일이 보다 일관적이도록 배치하기 때문에 다음과 같은 자연스러운 맵을 생성할 수 있다.

#figure(
  image("images/wavemap.png"),
  caption: [WFC 알고리즘으로 생성한 맵]
)

WFC 알고리즘을 이용해 다음과 같은 전자 회로도 그릴 수 있다.

#figure(
  image("images/wavecircuit.png"),
  caption: [WFC 알고리즘을 이용해 그린 회로]
)

= 참고문헌
#align(left, text(9pt)[
  Ceccherini-Silberstein, Tullio, et al. Cellular Automata and Groups. Springer Berlin Heidelberg, 2010.\
  Short, T., & Adams, T. (Eds.). (2017). Procedural generation in game design. CRC Press.\
  Gumin, M. (2016). Wave Function Collapse Algorithm (Version 1.0) [Computer software]. https://github.com/mxgmn/WaveFunctionCollapse
])