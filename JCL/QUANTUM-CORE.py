# JCL/QUANTUM-CORE.py
import numpy as np
from qiskit import QuantumCircuit, transpile
from qiskit_aer import AerSimulator
import sys

def analyze_event(energy):
    theta = np.pi * (min(float(energy), 1000) / 1000)
    qc = QuantumCircuit(1, 1)
    qc.ry(theta, 0)
    qc.measure(0, 0)
    sim = AerSimulator()
    job = sim.run(transpile(qc, sim), shots=1024)
    counts = job.result().get_counts()
    prob = (counts.get('1', 0) / 1024) * 100
    return prob

if __name__ == "__main__":
    # Lee el archivo generado por COBOL
    report_path = "REPORTS/DM-CANDIDATES.TXT"
    with open(report_path, "r") as f:
        lines = f.readlines()

    print("--- V.I.A. QUANTUM LAYER RESULTS ---")
    for line in lines:
        if "GeV" in line or (len(line.split()) > 0 and line.split()[0].replace('.','').isdigit()):
            try:
                energy = line.split()[0]
                q_prob = analyze_event(energy)
                # Imprimimos para que el script de Granite lo capture
                print(f"EVENT:{energy}|Q-PROB:{q_prob:.2f}%")
            except: continue