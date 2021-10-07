# Entre 0 et 100 - 3 indices
import random

win = False
attempts = 3

target = random.randint(0,100)


while(attempts and not win):
    attempts = attempts - 1
    try:
        input_n = int(input("Tentative " + str(3-attempts) + " : Entrez un nombre entre 0 et 100\n"))
    
    except:
        if(attempts):
            print("Veuillez entrer un entier entre 0 et 100")
        continue
    
    if (input_n == target):
        win = True
        print("Gagné, la solution était : " + str(target))
        break
    
    elif (input_n > target):
        print("C'est -")
        
    elif (input_n < target):
        print("C'est +")
        
if(not win):
    print ("Perdu, la solution était : " + str(target))
