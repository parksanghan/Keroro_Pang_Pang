== Influence 필드 설명 ==

code - influence 고유 구분 번호 설정. 
icon - 아이콘 이름을 쓰면된다.
requiredSp - SP 소비량 설정 (미구현?)
requiredItem - 아이템 사용 설정 (미구현?)
totalTime - 총 효과 유지 시간.
tickingTime - 적용하고자 하는 간격 시간. 기본값은 0이고, 0일때는 한번만 적용한다. 5로 설정하면 totalTime동안 5초마다 효과 발생.
flags - 주어진 인플런스(버프 그룹) 옵션을 말한다. 다음과 같은 토큰이 존재하며, 각 토큰은 or 연산(|)으로 조합할 수 있다.

  * KeepDead - 죽어도 유지된다.
  * KeepChar - 살아있는 동안만 유지된다.
  * NoHitChar - 공격 당하지 않은 상태에서만 효과가 유지된다. (= 공격당하면 효과가 해제된다.)
  * IntTicking - tickingTime마다 적용되게끔 한다. tickingTime이 0보다 크면 자동으로 적용된다.
  * IntExpiring - totalTime까지 유지된다. totalTime이 0보다 크면 자동으로 적용된다.

  조합예)
  flags="IntExpiring | KeepChar" - totalTime까지나 살아있는 동안만 유지된다.
  flags="IntExpiring | KeepDead" - totalTime까지나 캐릭터가 바뀔 때까지만 유지된다.

applyEffect - 적용시 나오는 이펙트 코드
releaseEffect - 해제시 나오는 이펙트 코드
kind - 버프/디버프 설정
overlap - 효과 중첩 설정

== Buff Element ==

아래와 같은 형식으로 늘리면 된다.

  <[parameter-name] value="[parameter-value]" />

[parameter-value]는 일반 수(ex.. 123)와 퍼센테이지(ex.. 20%) 2가지 형식을 지원한다. 



finalDamage  : 최종 데미지
speed        : 이동 속도
hp           : 현재 남은 HP
hitRate      : 명중률
immobile     : 타마마 2차 스킬 설정, 클라이언트 확인 필요
information  : 쿠루루 1차 스킬 설정
jamming      : 쿠루루 2차 스킬 설정
respawnTime  : 리스폰 시간
respawnSp    : 리스폰 시 SP 추가
lockTarget   : 유도탄 설정 - 0, 1로 값 설정
transparency : 캐릭터 투명, 도로로 1차 및 필드 아이템
MaxHP        : 최대 HP
SP           : 현재 남은 SP
MaxSP        : 최대 SP
pang         : 게임 머니 획득
jump         : 다중 점프
allDamage    : 모든 데미지
damageImmune : 무적
lockTarget   : 백발백중 탄 설정
bulletReflection : 반사탄 설정
multiRocketShot : 다중포탄 설정