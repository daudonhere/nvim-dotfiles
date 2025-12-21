def outer():
    for i in range(3):
        if i % 2 == 0:
            print("even", i)
        else:
            print("odd", i)

    print("done")
