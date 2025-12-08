# MATLAB Optimization Algorithms Collection

This repository contains several MATLAB `.m` files implementing foundational algorithms in linear programming, integer programming, quadratic programming, and combinatorial optimization. Each script/function is listed below with a brief explanation.

---

## 📂 Files Overview

### **1. interiorPointalg.m**
Implements an **interior-point algorithm** for solving quadratic programs (QP).  
Key features:
- Newton step on KKT conditions  
- Complementarity update via barrier parameter  
- Feasibility line search to maintain `x > 0`, `z > 0`  
- Stops when KKT residual is sufficiently small  
**Outputs:** optimal primal `x`, dual `y`, slack `z`, and iteration count.

---

### **2. DualSimplexAlg.m**
Implements the **dual simplex algorithm** for linear programs.  
Features:
- Builds initial tableau from basis  
- Iteratively restores primal feasibility while keeping dual feasibility  
- Uses ratio test on reduced costs  
**Outputs:** optimal objective value, optimal basic feasible solution `x`, dual variables `y`.

---

### **3. SimplexAlg.m**
Implements the **primal simplex algorithm** for linear programs.  
Features:
- Constructs simplex tableau  
- Chooses entering and leaving variables using reduced costs and min-ratio rule  
- Performs pivoting and updates basis each iteration  
**Outputs:** optimal objective value and optimal solution vector.

---

### **4. minVertexCover.m**
Solves the **Minimum Vertex Cover** problem using integer programming (`intlinprog`).  
Model:
- Binary variable per vertex  
- Ensures each edge is covered by at least one selected vertex  
**Outputs:** the chosen vertex cover and optimal objective value.

---

### **5. maxMatching.m**
Standalone implementation of **Maximum Matching** via integer programming.  
Model:
- Binary variable per edge  
- Ensures no vertex is matched more than once  
**Outputs:** selected edges in the matching and objective value.

---

## 📝 Summary of Algorithms Included
- **Interior-point method** for QP  
- **Simplex method (primal)** for LP  
- **Dual simplex method** for LP  
- **Integer programming formulation** for:
  - Minimum Vertex Cover  
  - Maximum Matching  

These implementations are designed to help understand the mechanics of optimization algorithms through explicit matrix operations and tableau updates.

---

## 📦 Requirements
- MATLAB  
- Optimization Toolbox (for `intlinprog` in vertex cover and matching)

---

## 📁 Usage
Each `.m` file defines its own function. Call them directly from MATLAB by passing the appropriate inputs (matrices, costs, basis indices, etc.).
