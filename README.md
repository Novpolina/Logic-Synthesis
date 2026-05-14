# Logic Synthesis with Yosys & Sky130 

Этот проект демонстрирует базовый маршрут логического синтеза и статического временного анализа для цифровых устройств с использованием Open-Source EDA и **Sky130**.

## Инструменты
* **Среда:** WSL2 (Ubuntu), Docker
* **Синтез:** Yosys (через LibreLane)
* **Тайминги:** OpenSTA
* **PDK:** Sky130 High Density (`sky130_fd_sc_hd`)

## Структура проекта
* `pwm_generator.v` — параметризуемый 8-битный ШИМ-генератор (основной дизайн).
* `comparator.v` — 2-битный синхронный компаратор (базовый тест).
* `constraints.sdc` — файл временны́х ограничений (Clock period: 10ns / 100 MHz).
* `timing.tcl` — скрипт для запуска тайминг-анализа в OpenSTA.
* `netlist_out_pwm.v` / `netlist_out.v` — сгенерированные нетлисты.

## Основные результаты (PWM Generator)
Синтез был успешно выполнен с маппингом на стандартные ячейки библиотеки Sky130. 
* **Площадь:** 46 технологических ячеек (включая 9 D-триггеров `sky130_fd_sc_hd__dfrtp_1`).
* **Тайминги:** Временные ограничения успешно выполнены. Запас по времени составил **9.02 ns** (при периоде 10 ns), что свидетельствует о возможности работы дизайна на частотах свыше 1 ГГц.

## Запуск
Для воспроизведения результатов необходимо запустить контейнер LibreLane и выполнить скрипт синтеза:
```bash
# Запуск контейнера LibreLane
python3 -m librelane --dockerized

# Логический синтез в Yosys
yosys
> read_verilog pwm_generator.v
> proc; opt; techmap; opt;
> dfflibmap -liberty <path_to_sky130_fd_sc_hd__ff_n40C_1v65.lib>
> abc -liberty <path_to_sky130_fd_sc_hd__ff_n40C_1v65.lib> -D 5 -constr constraints.sdc
> stat
> write_verilog netlist_out_pwm.v

# Временной анализ в OpenSTA
sta timing.tcl