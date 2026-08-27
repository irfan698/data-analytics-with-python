#Hi, I am Irfan Arhsad and learning Data Analytics with Saylani institute.
# My first assigment are following below

# 01. print your name with your father name and date of birth 
# using suitable escape character                     
print('Irfan Arshad\nMuhammad Arshad\n26-05-1994')     

# 02. Wirte a small bio with variable and print it using pirnt function
my_bio = "My name is Irfan Arshad and I am learning in Data Analytics with python bigest institute Saylani."
print("My Bio is: ", my_bio)

# 03.Write a programme in which use all the operators we can use python
a = 10
b = 25
print("===All Opertor is following====")
print("Add operator", a+b)
print("Minus operator", a-b)
print("Multiple operator", a*b)
print("Divide operator", a/b)
print("Modolue operator", a%b)
print("Power operator", a**b)

# 04. Marks english, Islamiat, Maths out of 100
# Total Marks is 300
# Calcualte its percentage

Marks_Eng = 67
Marks_Islm = 75
Marks_Math = 89

Total_Marks = 300
Percentage = (Marks_Eng+Marks_Islm+Marks_Math)/Total_Marks
print("Percentage is :",Percentage)

# 05.Take a value of two variable a and b swap their variable without using 
# 3rd variable and print before and after swap

a = 20
b = 40 

print("Before swap", a,b)
a, b = b, a 
print("After swap", a,b)

# 06. Take a circle of a radius form a variable and calculate area and 
# Circumference using pi = 3.14159

r = 3.9
pi = 3.14159

area = pi*r*r
circum = 2*pi*r

print("The area is:", area)
print("The Circumference is:", circum)

# 07. Take the price of item and discount in variable calculate and print
# the discount amount and the final price after discount

price = 350
disc = 0.15   # its means 15%

disc_amout = 350 * 0.15
price_after_disc = price - disc_amout

print("Discount Amount is:", disc_amout)
print("Price After Discount is:", price_after_disc)