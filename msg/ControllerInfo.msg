# One control mode a running autopilot node can be switched into.
#
# Deliberately a struct rather than parallel string arrays: VehicleInfo's `info[]`
# already showed that a positional convention ("index 0 is the vehicle name") forces
# every subscriber to guess, and cannot be extended without breaking them.

# Machine-readable identifier, stable across releases. This is what
# ActivateController.name expects, e.g. "SAFETY", "DIRECT", "Baseline".
string name

# Operator-facing one-line description of who owns the control loop in this mode,
# e.g. "PX4 attitude, rate, mixer" or "Autopilot raw motors".
string description

# True for the mode currently flying the vehicle.
bool active

# False when the mode exists but cannot be entered right now (e.g. it is the mode
# already active, or a precondition is unmet). `reason` says why when false.
bool selectable
string reason
