---
title: 'Verification Object: Design Specification and Code for Synchronous FIFO'
date: 2025-07-22T18:52:07+08:00
draft: false
fenbao_tags: ["Beginner Task", "Synchronous FIFO"]
summary: "Verification object for beginner tasks"
---

## Design Specification

### Module Name

`SyncFIFO`

### Description

This module implements a 32-bit wide synchronous FIFO (First-In-First-Out) buffer with a capacity of 16 elements. The FIFO is used to temporarily store data, providing write and read operations, and supports full/empty status indication. It features clock-synchronized behavior, suitable for data stream processing, interface buffering, and other scenarios. This design follows synchronous operation using a single clock signal for both read and write.

### Port Description

| Port Name  | Direction | Width (bit) | Description                                      |
| -------- | ------ | ------- | --------------------------------------------- |
| clk      | input  | 1       | Clock signal                                    |
| rst_n   | input  | 1       | Active-low reset signal; initializes the FIFO when low     |
| we_i    | input  | 1       | Write enable signal, active-high; when 1, allows data to be written to the FIFO |
| re_i    | input  | 1       | Read enable signal, active-high; when 1, allows data to be read from the FIFO |
| data_i  | input  | 32      | Data to be written to the FIFO                      |
| data_o  | output | 32      | Data read from the FIFO                          |
| full_o  | output | 1       | Indicates whether the FIFO is full                    |
| empty_o | output | 1       | Indicates whether the FIFO is empty                    |

### Functional Description

* **Write Operation**:

  * When `we_i` is 1, the FIFO can receive data and store it into the internal buffer `ram`.

  * The write pointer `wptr` indicates the next write position and increments with each write operation.

  * When the FIFO is full, `full_o` is 1 and the write operation is invalid.

* **Read Operation**:

  * When `re_i` is 1, the FIFO outputs data from `ram` based on the read pointer `rptr`.

  * The read pointer `rptr` indicates the next read position and increments with each read operation.

  * When the FIFO is empty, `empty_o` is 1 and the read operation is invalid.

* **Pointer Update**:

  * `wptr` (write pointer) and `rptr` (read pointer) are updated on the rising edge of the clock. `rptr` is updated only when `re_i` is valid and the FIFO is not empty; `wptr` is updated only when `we_i` is valid and the FIFO is not full.

  * During FIFO operation, by comparing the positions of `wptr` and `rptr`, the FIFO automatically adjusts the read and write positions of data.

* **Counter**:

  * `counter` is used to track the amount of data in the FIFO (from 0 to 16). Each time data is written, `counter` is incremented by 1; each time data is read, `counter` is decremented by 1.

  * When `counter` is 0, the `empty_o` signal is 1, indicating the FIFO is empty; when `counter` is 16, the `full_o` signal is 1, indicating the FIFO is full.

### Timing and Reset

* **Synchronous Timing**: All operations (write, read, pointer update, counter update) are synchronized to the rising edge of the clock signal.

* **Reset**: When `rst_n` is low, all internal pointers (`wptr`, `rptr`) and data output (`data_o`) of the FIFO are cleared, and the counter `counter` is reset to 0.

### Functional Block Description

1. **Pointer Update:**

   * Responsible for synchronously updating write and read pointers.

   * Within each clock cycle, if `we_i` is 1 and the FIFO is not full, data is written to the FIFO and `wptr` increments.

   * If `re_i` is 1 and the FIFO is not empty, data is read and output, and `rptr` increments.

2. **Counter Update:**

   * The counter `counter` is used to track the current amount of data in the FIFO.

   * Each write operation increments `counter`; each read operation decrements `counter`.

   * When the FIFO is full, `counter` reaches 16 and `full_o` is 1; when the FIFO is empty, `counter` is 0 and `empty_o` is 1.

### Design Constraints and Assumptions

1. **Data Width and Depth**: This design uses a 32-bit width and 16-depth FIFO, suitable for small-scale data caching requirements.

2. **Clock Domain**: The FIFO module is designed to operate in a single clock domain, and the clock and reset signals are synchronous.

3. **Data Storage**: The FIFO data is stored in a 16-element RAM array, with each element being 32 bits.

4. **Simultaneous Read/Write**: When the FIFO is neither full nor empty, simultaneous read and write operations are allowed.

### Boundary Conditions

1. When the FIFO is full and the `we_i` signal is high, the write operation is blocked.

2. When the FIFO is empty and the `re_i` signal is high, the read operation is blocked.



## Design Code

```verilog
module SyncFIFO (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        we_i,
    input  wire        re_i,
    input  wire [31:0] data_i,
    output reg  [31:0] data_o,
    output wire        full_o,
    output wire        empty_o
);

  reg [31:0] ram[16];

  reg [3:0] wptr;
  reg [3:0] rptr;
  reg [4:0] counter;

  wire rvalid, wvalid;

  assign rvalid = re_i && !empty_o;
  assign wvalid = we_i && !full_o;

  always @(posedge clk) begin : PTR_UPDATE
    if (!rst_n) begin
      wptr   <= 0;
      rptr   <= 0;
      data_o <= 0;
    end else begin
      if (rvalid) begin
        rptr   <= rptr + 1;
        data_o <= ram[rptr];
      end
      if (wvalid) begin
        wptr      <= wptr + 1;
        ram[wptr] <= data_i;
      end
    end
  end

  always @(posedge clk) begin : COUNTER_UPDATE
    if (!rst_n) counter <= 0;
    else if (rvalid ^ wvalid) begin
      if (rvalid) counter <= counter - 1;
      if (wvalid) counter <= counter + 1;
    end
  end

  assign full_o  = counter == 5'd16;
  assign empty_o = counter == 0;

endmodule
```
