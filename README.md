# Digital-Design-of-FIR-Filter
Hardware Design and Verification of a configurable and parametrized 50th order low-pass FIR filter starting from MATLAB Modeling to Verilog RTL Design and Simulink Testing with .wav audio files.

**Design Specifications:**
- Filter Order: 50 (51 Taps)
- Windowing Method: Hamming
- Sampling Frequency: 44.1KHz
- Cutoff Frequency: 3.5KHz
- Sampled Data Input Size: 16-bit
- Filter Coefficients Size: 16-bit
- Filtered Data Output Size: 32-bit

**Design Flow:**
*Check the Documentation*
1. Getting Started with FIR Filter Concept
2. System Modeling using *MATLAB*
3. FIR Filter Architecure (Block Diagram)
4. Hardware Design using *Verilog*
5. Testbench and Simulation using *Vivado*
6. .WAV File Filtering using *Simulink*

**Project Files:**
1. **_src/fir_filter.v_**: verilog design
2. **_tb/fir_filter_tb.v_**: verilog testbench
3. **_tb/fir_filter_tasks.v_**: verilog testbench tasks
4. **_simulink_test/fir_simulink_test.slx_**: simulink project
5. **_simulink_test/fir_filter_simulink_test.v_**: verilog design for simulink
6. **_simulink_test/signal.wav_**: original signal audio file for simulink
7. **_simulink_test/ noise.wav_**: noise signal audio file for simulink
8. **_Digital Design of FIR Filter.pdf_**: project documentation

![FIR Cover1](https://user-images.githubusercontent.com/52181539/219257508-47a6d1d0-ade1-4ba6-8bde-609f671d2a25.jpg)
