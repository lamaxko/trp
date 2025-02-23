def divide_by_zero():
    x = 1 / 0  # Error: Division by zero

def missing_variable():
    print(undeclared_variable)  # Error: NameError - undeclared variable

def type_mismatch():
    number = 10
    result = number + "text"  # Error: TypeError - adding int and str

def index_error():
    my_list = [1, 2, 3]
    print(my_list[5])  # Error: IndexError - out of range

def file_not_found():
    with open("non_existent_file.txt", "r") as f:  # Error: FileNotFoundError
        content = f.read()

def call_functions():
    divide_by_zero()
    missing_variable()
    type_mismatch()
    index_error()
    file_not_found()

# Run the functions
if __name__ == "__main__":
    call_functions()


