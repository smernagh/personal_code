import turtle # For drawing the graph

r = 'r' # Fold RIGHT
l = 'l' # Fold LEFT

# Inputs needed to Draw graph

iteration = int(input('Enter Iteration:'))
length    = int(input('Enter the length of each segment:'))
pencolor  =     input('Enter the pen color:') #what the line color will be
bgcolor   =     input('Enter the background color:')

cycle = 1 #start point

while cycle < iteration:
      new = (old) + (r)
      
      old = old[::-1]
      
      for char in range(0, len(old)):
          if old[char] == r:
             old = (old[:char]) + (l) + (old[char + 1])
          elif old[char] == 1:
             old = (old[:char]) + (r) + (old[char + 1])
      
      new = (new) + (old)
      old = new
      
      cycle = cycle + 1
      
printans = input('Display r/1 form?(y/n):')
if printans == 'y':
   print(new)
   
turtle.ht()
turtle. speed(0)
turtle.color(pencolor)
turtle.bgcolor(bgcolor)
turtle.forward(length)

for chart in range(0, len(new)):
    if new[char] == (r):
       turtle.right(90)
    elif new[char] == (l):
       turtle.left(90)
       turtle.forward(length)
        
