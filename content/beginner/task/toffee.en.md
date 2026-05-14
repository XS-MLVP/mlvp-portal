---
title: 'Learning Task 2: Toffee Part'
date: 2025-07-22T18:52:07+08:00
draft: false
fenbao_tags: ["Beginner Task", "Toffee"]
summary: "Building a verification environment with Toffee"
---

The design specification and code for the module under verification are available at: [Synchronous FIFO Design Specification and Code](../sync_fifo).

## 1. Managing Test Cases with toffee-test

### Preparation

Create a `pyproject.toml` file in the root directory with the following content:

```toml
[tool.pytest.ini_options]
pythonpath = "./"
```

> If you are curious about the role of `pyproject.toml` here, please refer to https://docs.pytest.org/en/stable/explanation/goodpractices.html

### Exercise

Manage the test cases you wrote earlier using toffee-test:

1. Create a `tests` folder

2. Create a `test_smoke.py` file under the `tests` folder and manage your previously written code using toffee-test.


## 2. Encapsulating DUT Using Bundle

### Preparation

Create `tests` and `bundle` folders. Create an `__init__.py` file under the `bundle` folder to store Bundle code; create a `test_smoke.py` file under the `tests` folder to store the verification code for this exercise.

### Exercise

In this exercise, you need to create specified Bundle classes to encapsulate the DUT, then write some new test cases:

1. Encapsulate the FIFO ports based on **port functionality**:

    - Create a `WriteBundle` class containing ports related to **writing data to the FIFO**.

    - Create a `ReadBundle` class containing ports related to **reading data from the FIFO**.

    - Create an `InternalBundle` class to encapsulate FIFO internal state signals.

    - If you think you need to add other Bundles, feel free to implement them.

2. Add a `dequeue` method to `ReadBundle`: Implement the `dequeue(self)` method, which performs one read operation.

3. Add an `enqueue` method to `WriteBundle`: Implement the `enqueue(self, data)` method, which performs one write operation.

4. Using the encapsulated Bundle environment, create a test case `test_bundle` following the test process of the previous `test_smoke_dut`.

5. Using the encapsulated Bundle environment, write a test case `test_full_empty`:

    - First fill the fifo, then check if the `full_o` signal is 1

    - Then empty the fifo, and check if the `empty_o` signal is 1

    - When emptying the fifo, verify that the dequeue sequence matches the enqueue sequence

## 3. Further Encapsulation Using Agent

### Preparation

Store the code for this exercise in `agent/__init__.py`

### Exercise

This exercise requires writing an Agent for the DUT, then using the written Agent to build some test cases:

1. Write the `FIFOAgent` class:

    * Accept `ReadBundle`, `WriteBundle`, and `InternalBundle` during initialization.

    * Implement a `reset` driver method to perform FIFO reset operation.

    * Wrap the `enqueue` and `dequeue` methods implemented at the `Bundle` level as driver methods of the `Agent`.

2. Using the parameters encapsulated by `FIFOAgent`, create a test case `test_agent` following the test process of `test_smoke_dut`.

3. Reflection: Review the `enqueue` and `dequeue` methods you implemented in the `Bundle` and `Agent` exercises. Is it more appropriate to implement these operation logics at the `Bundle` layer (as `Bundle` methods) and then simply wrap them with `@driver_method` at the `Agent` layer, or is it more appropriate to write the complete signal operation logic directly in the `Agent`'s `@driver_method`? Or is there a better approach? Why? (Hint: Consider code reuse, responsibility separation, and abstraction levels)

4. Reflection: When we encapsulate different input functions as multiple driver functions, it seems that only one driver function can be executed serially at a time. What should we do when multiple functions need to be applied simultaneously? Please read the [How to call multiple driver functions simultaneously](https://pytoffee.readthedocs.io/zh-cn/latest/cases/executor.html#id2) section in the toffee documentation, explore the basic usage of `Executor`, and then complete the encapsulation of **simultaneous read/write operations** in the Agent. (Hint: The `Env` in the documentation does not affect understanding and will be introduced later).

## 4. Collecting Functional Coverage

### Preparation

+ Make sure you understand the synchronous FIFO design specification.

+ Make sure your FIFO Agent and Bundle code are working.

+ Create a `coverage` folder (or under your existing `env` folder) to store coverage model definition code (e.g., `fifo_coverage.py`).


### Exercise

Collect functional coverage and analyze it:

1. **Break down SyncFIFO functional points and test points:** Based on your understanding of the synchronous FIFO specification (or refer to standard FIFO behavior), list its key functional points. For example:  

    * Basic operations: successful write, successful read, no operation.

    * Boundary states: attempting to read when FIFO is empty, attempting to write when FIFO is full, writing when FIFO is empty, reading when FIFO is full.

    * Pointer behavior: write pointer catches up to read pointer (write full), read pointer catches up to write pointer (read empty), pointer wraparound.

    * Data integrity: data written matches data subsequently read.

    * Reset behavior: after reset, FIFO should be empty, pointers reset.  

    For each functional point, think about which test points (input stimulus conditions) are needed to verify it, and which signals (coverage points) need to be observed to confirm the functional point is covered.

2. **Write the SyncFIFO functional coverage model:**

    * Create corresponding `CovGroup` functions for the functional points broken down above (e.g., `get_cover_group_boundary_operations`).

    * Inside each `CovGroup` function, use `add_watch_point` to add coverage points and Bins to measure whether the corresponding test points are covered. Use the comparison functions, check functions, factory functions + Enum, and other techniques introduced earlier.

    * Consider which sampling method each `CovGroup` should use (periodic sampling vs. manual sampling based on specific sequences), and set it accordingly in the fixture.

3. **View reports and try to improve functional coverage:**

    * Run the test case with coverage collection enabled and view the generated coverage report (if you are not familiar, please refer to Toffee documentation or the third beginner tutorial)

    * Analyze the report and identify uncovered Bins

    * Try adding new test cases to improve coverage, but 100% functional coverage is not required—any improvement is acceptable

## 5. Writing Reference Model and Packaging Verification Environment

### Preparation

Create folders and files:

+ `env/__init__.py`: stores the verification environment Env

- `ref/__init__.py`: stores the reference model code

### Exercise

Write the reference model and package the verification environment:

1. Write a reference model for the synchronous FIFO and integrate it into the verification environment

2. Achieve 100% functional coverage
