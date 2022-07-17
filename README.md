# Infineon-Summer-School

This is a project written in verilog for the first week of Infineon-Summer-School. The purpose was to implement a Universal Asynchronous Receiver-Transmitter. You can check the documentation on which this project is based [here](docs/IFROSummerSchool.pdf). For verifing the implementation I used Cadence XCelium.

This is how the first week looked like:

- Prologue
  - visited a couple of the company's labs
  - listened to a presenation about the stages of developing a product
  
- First day (beginner friendly)
  - learned to use X2GO (how to create a session, how to add shared folders)
  - customized my workspace to be nicer
  - rediscovered basic linux commands (cd, pwd, ls with all the nice flags and others)
  - helped two colleagues understand how to work their way in the X2GO client and linux
  - revisioned base CID concepts
  - learned to use gedit as text editor and Cadence XCelium as simulator
  - started writing the [baudrate generator](rtl/tx_baud_gen.v) to lower the frequency of the systems clock

- Second day
  - wrote a [testbench](tb/tx_baud_gen_TB.v) for the [baudrate generator](rtl/tx_baud_gen.v) to check all the 4 possible rates
  - kept the .v's organized by using separated folders for [register-transfer level designs](rtl) and the [testbenches](tb)
  - debugged the code of some fellow participants (most of them encountered troubles with creating the option to have 4 possible rates)
  - started writing the [first in first out buffer](rtl/fifo_buffer.v) to create a storage structure that follows the fifo rule
- Third day
  - improved some lines of code in the control part of the [fifo buffer](rtl/fifo_buffer.v)
  - wrote a [testbench](tb/fifo_buffer_TB.v) for the [fifo buffer](rtl/fifo_buffer.v) to check the empty and full flags and if it respects the fifo rule
  - designed on paper the [uart_tx](rtl/uart_tx.v) with its states
  - started writing the [uart_tx](rtl/uart_tx.v) which is a finite state machine at base
  - helped a couple of colleagues understand the non-blocking attribution and how to move from one state to another
  - revisioned CID [automated](https://wiki.dcae.pub.ro/index.php/CID_aplicatii_13_:_Automate_finite) concepts
- Fourth day (pray day)
  - finished the [uart_tx](rtl/uart_tx.v) without writing a testbench for it and started praying
  - wrote the main file of the project [uart_transmitter](rtl/uart_transmitter.v) which linked all the other files and continued the prayers
  - wrote the nicest [testbench](tb/uart_transmitter_TB.v) that I could, to see if the [uart_transmitter](rtl/uart_transmitter.v) actually works
  - simulated the testbench a couple of times and kept on modifying the [uart_transmitter](rtl/uart_transmitter.v) until it was showing the normal [waveform](images/uart_transmitter_TB_sim.png)
  - encountered some problems going from STOP to IDLE so kept on modifying until the [waveform](images/uart_transmitter_TB_sim_2.png) actually worked
  - reviewed the entire code, and added comments for a better understanding
  
  >Future repeats itself
  