---
title: 'Learning Task 1: Picker Part'
date: 2025-07-22T18:52:07+08:00
draft: false
fenbao_tags: ["Beginner Task", "Picker"]
summary: "Get familiar with the basic usage of Picker"
---

The code and documentation for the verification object are located at: [Design Specification and Code for Sync FIFO](../sync_fifo).

## Preparation

1. Create the project directory structure:

```bash
fifo_test/
├── rtl/        # Place the FIFO RTL code here
└── test_smoke.py  # Test case file
```

* Put the Sync FIFO code under `rtl`, and name it `SyncFIFO.v`.

## 1. Creating and Initializing the DUT Class

1. Create a DUT class for the Sync FIFO

2. Create a `test_reset_dut` function as a test case: pull the `rst_n` signal low for 5 cycles, then pull it high for 2 cycles, and dump the waveform signal

3. Observe the waveform and focus on: In the default write mode, when does pulling `rst_n` high take effect?

4. Change the write mode of `rst_n` to immediate mode `Imme`, observe again when does pulling `rst_n` high take effect? Compare the waveform with the default case.

5. Think: When initializing a module, is assigning a value to `rst_n` alone sufficient? What else needs to be considered?

    - You may read the following materials to help you think:

    - >> (4.1 Value set) The value set in Verilog HDL contains four basic values:
        >>
        >> - `0`: represents logic zero or false condition
        >> - `1`: represents logic one or true condition
        >> - `x`: represents **unknown logic value**
        >> - `z`: represents **high impedance state**
        >
        >> (4.2.1 Net declarations) The initial value of `wire` type is `z`
        >
        >> (4.2.2 Variable declarations) The initial value of `reg` type is `x`
        >
        >—— From [IEEE Std 1364-2005, IEEE Standard for Verilog® Hardware Description Language](https://ieeexplore.ieee.org/document/1620780)

    - > > Verilator is essentially a two-state simulator, so for `x` and `z` values it will assign a specific constant value, which can be a random number or a fixed value, depending on the control of [related options](https://veripool.org/guide/latest/exe_verilator.html#cmdoption-9).
        >
        > —— From the [Unknown States](https://veripool.org/guide/latest/languages.html#unknown-states) section of the Verilator documentation

## 2. Writing the Reset Test

Based on the test case `test_reset_dut`, after the reset is complete, use `assert` to verify whether the FIFO output and read/write pointers are 0.

## 3. Writing the Smoke Test

> The smoke test is the first line of defense in the verification process, used to quickly confirm whether the basic functions of the system are working properly.
>
> This term originated from the hardware industry: when new hardware is powered on for the first time, if there is no smoke, it passes the initial test.
>
> In chip verification, smoke tests can detect serious problems early in development, saving a lot of debugging time.

Add a test case `test_smoke_dut` with the following test steps:

1. Reset the DUT

2. Write two pieces of data to the FIFO:

    1. Set `we_i` high, assign `0x114` to `data_i`, hold for one cycle, then check whether `empty_o` and `full_o` are 0

    2. Set `we_i` high, assign `0x514` to `data_i`, hold for one cycle

3. Read two pieces of data from the FIFO:

    1. Set `we_i` low, `re_i` high, hold for one cycle, then read `data_o` and verify the result is `0x114`

    2. Set `we_i` low, `re_i` high, hold for one cycle, then read `data_o` and verify the result is `0x514` and `empty_o` is 1

Then run the test case to verify whether the DUT passes the test.
