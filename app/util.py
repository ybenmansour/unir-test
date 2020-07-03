def convert_to_int(op):
    try:
        if "." in op:
            return float(op)
        else:
            return int(op)

    except ValueError:
        raise TypeError("Operator cannot be converted to number")
