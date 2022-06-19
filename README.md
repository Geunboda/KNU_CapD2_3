# NLP 기반의 Java Thread Dump 분석 with Google Korea
경북대학교 종합설계프로젝트2 - 3팀

- [1. 소개](#1-소개)
- [2. 과제 목표](#2-과제 목표)

## 1. 소개
 현재 우리가 살고 있는 4차산업혁명 시대엔 IT산업 전반에 인공지능이 곳곳에 포진해 있다고 해도 과언이 아닐 정도다. 인공지능과 머신러닝 기술은 산업을 넘어서 교육, 문화, 의료 등 우리 삶 속에서 인공지능의 적용을 볼 수 있다고 기대해도 좋기 때문이다.

<img width="750" alt="image" src="https://user-images.githubusercontent.com/54229039/174465607-a0d2dee4-978f-4cf5-9b3e-76f224244763.png">

> ▲<도표> Google Cloud Industries: Artificial Intelligence acceleration among manufacturers


<br/>덧붙여, 인터넷 사용자 수의 증가로 인해 로그 데이터 양이 증가하였다. 로그 데이터는 실제 현실에서 발생하는 사건을 데이터로 기록한 것으로, 로그 데이터를 분석하면 실제 현황에 대해서 자세히 확인할 수 있다. 

<img width="400" alt="image" src="https://user-images.githubusercontent.com/54229039/174465632-0d2a78d3-96a8-457a-aa3c-29a3b296903f.png">

> ▲<그래프> JetBrain 2020, Java 사용률 조사 결과

<br/>그 중 유용하게 사용되는 로그 데이터 중 하나는 바로 Java Thread Dump이다. Thread Dump는 정형화된 데이터이며 웹 서버에서는 많은 수의 동시 사용자를 처리하기 위해 수십~수백 개 정도의 Thread를 사용한다. 두 개 이상의 Thread가 같은 자원을 이용할 때는 필연적으로 Thread 간에 경합(Contention)이 발생하고 경우에 따라서는 데드락(Deadlock)이 발생할 수도 있다. 이러한 Thread의 정보를 담고 있는 로그 데이터인 Thread Dump를 분석하여 문제 발생 시에 그 문제를 해결할 수 있는 방법을 찾기 쉬우며 문제 발생 전에도 Thread Dump를 분석하여 Contention과 Deadlock 등 앞으로 발생할 문제를 사전에 예방할 수 있다. 때문에 서버 운영시 Thread Dump 분석이 필요하다. 

하지만 운영시점에서는 시스템 특성에 따라 다양한 사용자들이 서비스를 동시에 사용하기 때문에 로그 추적이 어려우며, 로그 추적을 하지 못해 문제 원인 추적을 포기하는 경우도 자주 발생한다. 이 로그 데이터를 하나하나 인간이 구분하고 분석하는데에는 물리적인 한계가 있을 수 밖에 없다. 그리고 현재 사용되는 Thread Dump 분석 도구들은 단순하게 running, sleeping, blocked 정도로 간단한 덤프 분석만을 지원한다.

<img width="500" alt="image" src="https://user-images.githubusercontent.com/54229039/174465640-10455dc2-e1ab-410f-8b0d-360c3dfe21f3.png">

> ▲<그림> Thread Dump 분석을 지원하는 온라인 Dump 분석 사이트 FastThread

<br/>때문에 이러한 Thread Dump를 좀 더 체계적이고 효과적으로 분석할 수 있는 도구의 필요성이 대두되고 있다.

## 2. 과제 목표
![dump drawio (3)](https://user-images.githubusercontent.com/54229039/174466076-e09cbc1a-7fba-462f-b895-686b22344ba3.png)

<img width="500" alt="image" src="https://user-images.githubusercontent.com/54229039/174466053-a580d56f-9231-4481-980e-b5b921ca1a21.png">

## . 팀원
| Name    | 김보근                                     | 김나형                                   | 김다혜                                       | 옥명주                                 | 이현지                                 |
| ------- | ---------------------------------------- | ---------------------------------------- | -------------------------------------------- | -------------------------------------- | -------------------------------------- |
| Profile | <img width="200px" src="https://github.com/Geunboda.png" />                               | <img width="200px" src="https://github.com/lamknh.png" />                               | <img width="200px" src="https://github.com/Loreha0223.png" />                                   | <img width="200px" src="https://github.com/dhraudwn.png" />                             | <img width="200px" src="https://github.com/hyunji-lee99.png" />                    |
| role    | Team Leader, Frontend                 | Backend                                  | Frontend                                     | Backend                                | Backend                                |
| Github  | [@Geunboda](https://github.com/Geunboda) | [@lamknh](https://github.com/lamknh) | [@Loreha0223](https://github.com/Loreha0223) | [@dhraudwn](https://github.com/dhraudwn) | [@hyunji-lee99](https://github.com/hyunji-lee99) |
