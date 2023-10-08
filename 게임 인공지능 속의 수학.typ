#set text(font: "Noto Serif KR")

#align(center, text(17pt)[
  *게임 인공지능 속의 수학*
])

#align(right, text(10pt)[
  한남대학교 수학과
  
  20172581 김남훈
])

= 1. 게임에서 인공지능의 역할
게임 속 세계는 크게 플레이어와 NPC, 그리고 그들이 위치하는 맵으로 구성된다. NPC는 적대적 NPC(일명 몬스터)와 비적대적 NPC 가 존재하는데, 이들은 인공지능에 기반해 행동한다. 인공지능이 없다면 이들 NPC는 한 자리에 가만히 있으며 플레이어와 어떤 상호작용도 하지 않을 것이다. 이들이 움직이게 하고, 플레이어를 공격하거나 플레이어에게서 도망치게 하는 등 다양한 행동을 부여하는 것이 바로 인공지능의 역할이다.

= 2. 방향 그래프와 오토마타의 간략한 설명
게임 속 인공지능을 구현하는 기술은 크게 둘로 나눌 수 있다. 퍼셉트론과 유한상태기계가 그것인데, 여기서는 유한상태기계만을 다룰 것이다. 유한상태기계를 이해하기 위해 필요한 두 개념을 먼저 이야기해보자. 첫째는 방향 그래프이다.

=== 방향 그래프
방향 그래프는 간단히 말해 각 변에 방향이 정의되어 있는 그래프이다. $V$가 그래프 $G$ 의 정점이라 하자. $G$ 가 변 $(x, y)$ 를 갖는다면 $x$ 에서 $y$ 로 가는 길이 $1$ 인 경로가 존재하지만, 변 $(y, x)$ 를 갖지 않는다면 에서 $y$ 로 $x$ 가는 길이 $1$ 인 경로는 존재하지 않는다. 방향이 없는 그래프에서 $(x, y)$ 와 $(y, x)$ 를 구분하지 않는 것과 대비되는 방향 그래프의 특성이다.

=== 오토마타
오토마타는 주어진 입력과 현재 상태에 따라 자신의 상태를 변화시키는 가상의 기계이다. 오토마타는 자신이 가질 수 있는 상태들의 집합 $V$ 와 받을 수 있는 입력의 집합 $Sigma$, 그리고 각 상태에서 특정한 입력을 받았을 때 어떤 상태로 변화하는지를 나타내는 함수 $delta : Q times Sigma arrow.r Q$ 로 이루어진다. 이 때 $Q$ 와 $Sigma$ 가 유한집합이라면, 처음 상태 $q_0 in Q$ 와 최종 상태(몬스터의 경우 죽음) $q_(omega) in Q$ 을 포함한 
$ cal(A) = (Q, Sigma, delta, q_0, q_(omega)) $
을 *유한상태기계* 라고 한다.

= 3. 유한상태기계를 이용한 게임 인공지능
#figure(image("몬스터 인공지능.svg", width: 90%), caption: [몬스터의 인공지능 예시])
게임 속 간단한 몬스터를 상상해보자. 이 몬스터는 평상시엔 맵을 돌아다니다, 플레이어를 발견하면 플레이어를 공격한다. 그러다 체력이 $10%$ 미만으로 감소하면 플레이어로부터 도주하며, 플레이어가 시야에서 벗어나면 다시 맵을 돌아다닌다. 그리고, 어떤 상태에서든 체력이 $0$ 이 되면 죽는다. 이를 다이어그램으로 나타내면, 위의 그림과 같을 것이다. 이 때, 정찰, 전투, 도주, 죽음은 각각의 상태가 되며 '체력이 $0$이 됨', '플레이어 발견', '플레이어 놓침', '체력이 $10%$ 미만' 은 각각의 입력이 되어 다음과 같은 표로 함수 $delta$ 를 나타낼 수 있을 것이다.

#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    [$delta$], [플레이어 발견], [플레이어 놓침], [체력이 $10%$ 미만], [체력이 $0$ 이 됨],
    [정찰], [전투], [정찰], [정찰], [죽음],
    [전투], [전투], [정찰], [도주], [죽음],
    [도주], [도주], [정찰], [도주], [죽음],
    [죽음], [죽음], [죽음], [죽음], [죽음]
  ),
  caption: [인공지능의 상태 변화를 표로 나타내기]
)

유한상태기계의 장점은, 각 상태에서 NPC 의 구체적인 행동(이동, 공격, 스킬 사용 등) 을 디자인할 때, 다른 상태를 고려할 필요가 없어져 설계가 단순해진다는 것이다. 이와 같이, 수학을 이용하면 게임 인공지능의 구현을 단순화할 수 있다.

= 참고문헌
#set text(size: 9pt)
Michael Spiser(2023) 『Introduction to the Theory of Computation』 CENGAGE Learning.

Reinhard Diestel(2010) 『Graph Theory』 Springer.

Sanjay Madhav(2010) 『Game Programming Algorithms and Techniques』 Addison-Wesley.