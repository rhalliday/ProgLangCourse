# University of Washington, Programming Languages, Homework 7, 
# hw7testsprovided.rb

require "./hw7.rb"

#  Will not work completely until you implement all the classes and their methods

# Will print only if code has errors; prints nothing if all tests pass

# These tests do NOT cover all the various cases, especially for intersection

#Constants for testing
ZERO = 0.0
ONE = 1.0
TWO = 2.0
THREE = 3.0
FOUR = 4.0
FIVE = 5.0
SIX = 6.0
SEVEN = 7.0
EIGHT = 8.0
TEN = 10.0

#Point Tests
a = Point.new(THREE,FIVE)
if not (a.x == THREE and a.y == FIVE)
	puts "FAILED: Point is not initialized properly"
else
	puts "Point is initialized properly"
end
if not (a.eval_prog([]) == a)
	puts "FAILED: Point eval_prog should return self"
else
	puts "Point eval_prog returns self"
end
if not (a.preprocess_prog == a)
	puts "FAILED: Point preprocess_prog should return self"
else
	puts "Point preprocess_prog returns self"
end
a1 = a.shift(THREE,FIVE)
if not (a1.x == SIX and a1.y == TEN)
	puts "FAILED: Point shift not working properly"
else
	puts "Point shift working properly"
end
a2 = a.intersect(Point.new(THREE,FIVE))
if not (a2.x == THREE and a2.y == FIVE)
	puts "FAILED: Point intersect not working properly"
else
	puts "Point intersect working properly"
end 
a3 = a.intersect(Point.new(FOUR,FIVE))
if not (a3.is_a? NoPoints)
	puts "FAILED: Point intersect not working properly"
else
	puts "Point intersect working properly"
end

#Line Tests
b = Line.new(THREE,FIVE)
if not (b.m == THREE and b.b == FIVE)
	puts "FAILED: Line not initialized properly"
else
	puts "Line initialized properly"
end
if not (b.eval_prog([]) == b)
	puts "FAILED: Line eval_prog should return self"
else
	puts "Line eval_prog returns self"
end
if not (b.preprocess_prog == b)
	puts "FAILED: Line preprocess_prog should return self"
else
	puts "Line preprocess_prog return self"
end

b1 = b.shift(THREE,FIVE) 
if not (b1.m == THREE and b1.b == ONE)
	puts "FAILED: Line shift not working properly"
else
	puts "Line shift working properly"
end

b2 = b.intersect(Line.new(THREE,FIVE))
if not (((b2.is_a? Line)) and b2.m == THREE and b2.b == FIVE)
	puts "FAILED: Line intersect not working properly"
else
	puts "Line intersect working properly"
end
b3 = b.intersect(Line.new(THREE,FOUR))
if not ((b3.is_a? NoPoints))
	puts "FAILED: Line intersect not working properly"
else
	puts "Line intersect working properly"
end

#VerticalLine Tests
c = VerticalLine.new(THREE)
if not (c.x == THREE)
	puts "FAILED: VerticalLine not initialized properly"
else
	puts "VerticalLine initialized properly"
end

if not (c.eval_prog([]) == c)
	puts "FAILED: VerticalLine eval_prog should return self"
else
	puts "VerticalLine eval_prog return self"
end
if not (c.preprocess_prog == c)
	puts "FAILED: VerticalLine preprocess_prog should return self"
else
	puts "VerticalLine preprocess_prog return self"
end
c1 = c.shift(THREE,FIVE)
if not (c1.x == SIX)
	puts "FAILED: VerticalLine shift not working properly"
else
	puts "VerticalLine shift working properly"
end
c2 = c.intersect(VerticalLine.new(THREE))
if not ((c2.is_a? VerticalLine) and c2.x == THREE )
	puts "FAILED: VerticalLine intersect not working properly"
else
	puts "VerticalLine intersect working properly"
end
c3 = c.intersect(VerticalLine.new(FOUR))
if not ((c3.is_a? NoPoints))
	puts "FAILED: VerticalLine intersect not working properly"
else
	puts "VerticalLine intersect working properly"
end

#LineSegment Tests
d = LineSegment.new(ONE,TWO,-THREE,-FOUR)
if not (d.eval_prog([]) == d)
	puts "FAILED: LineSegement eval_prog should return self"
else
	puts "LineSegement eval_prog return self"
end
d1 = LineSegment.new(ONE,TWO,ONE,TWO)
d2 = d1.preprocess_prog
if not ((d2.is_a? Point)and d2.x == ONE and d2.y == TWO) 
	puts "FAILED: LineSegment preprocess_prog should convert to a Point"
	puts "if ends of segment are real_close"
else
	puts "LineSegment converts to a Point"
end

d = d.preprocess_prog
if not (d.x1 == -THREE and d.y1 == -FOUR and d.x2 == ONE and d.y2 == TWO)
	puts "FAILED: LineSegment preprocess_prog should make x1 and y1"
	puts "on the left of x2 and y2"
else
	puts "LineSegment makes x1 y1"
end

d3 = d.shift(THREE,FIVE)
if not (d3.x1 == ZERO and d3.y1 == ONE and d3.x2 == FOUR and d3.y2 == SEVEN)
	puts "FAILED: LineSegment shift not working properly"
else
	puts "LineSegment shift working properly"
end

d4 = d.intersect(LineSegment.new(-THREE,-FOUR,ONE,TWO))
if not (((d4.is_a? LineSegment)) and d4.x1 == -THREE and d4.y1 == -FOUR and d4.x2 == ONE and d4.y2 == TWO)	
	puts "FAILED: LineSegment intersect not working properly"
else
	puts "LineSegment intersect working properly"
end
d5 = d.intersect(LineSegment.new(TWO,THREE,FOUR,FIVE))
if not ((d5.is_a? NoPoints))
	puts "FAILED: LineSegment intersect not working properly"
else
	puts "LineSegment intersect working properly"
end

#Intersect Tests
i = Intersect.new(LineSegment.new(-ONE,-TWO,THREE,FOUR), LineSegment.new(THREE,FOUR,-ONE,-TWO))
i1 = i.preprocess_prog.eval_prog([])
if not (i1.x1 == -ONE and i1.y1 == -TWO and i1.x2 == THREE and i1.y2 == FOUR)
	puts "FAILED: Intersect eval_prog should return the intersect between e1 and e2"
else
	puts "Intersect eval_prog returns the intersect between e1 and e2"
end

#Var Tests
v = Var.new("a")
v1 = v.eval_prog([["a", Point.new(THREE,FIVE)]])
if not ((v1.is_a? Point) and v1.x == THREE and v1.y == FIVE)
	puts "FAILED: Var eval_prog is not working properly"
else
	puts "Var eval_prog is working properly"
end 
if not (v1.preprocess_prog == v1)
	puts "FAILED: Var preprocess_prog should return self"
else
	puts "Var preprocess_prog return self"
end

#Let Tests
l = Let.new("a", LineSegment.new(-ONE,-TWO,THREE,FOUR),
             Intersect.new(Var.new("a"),LineSegment.new(THREE,FOUR,-ONE,-TWO)))
l1 = l.preprocess_prog.eval_prog([])
if not (l1.x1 == -ONE and l1.y1 == -TWO and l1.x2 == THREE and l1.y2 == FOUR)
	puts "FAILED: Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
else
	puts "Let eval_prog evaluate e2 after adding [s, e1] to the environment"
end

#Let Variable Shadowing Test
l2 = Let.new("a", LineSegment.new(-ONE, -TWO, THREE, FOUR),
              Let.new("b", LineSegment.new(THREE,FOUR,-ONE,-TWO), Intersect.new(Var.new("a"),Var.new("b"))))
l2 = l2.preprocess_prog.eval_prog([["a",Point.new(0,0)]])
if not (l2.x1 == -ONE and l2.y1 == -TWO and l2.x2 == THREE and l2.y2 == FOUR)
	puts "FAILED: Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
else
	puts "Let eval_prog evaluate e2 after adding [s, e1] to the environment"
end


#Shift Tests
s = Shift.new(THREE,FIVE,LineSegment.new(-ONE,-TWO,THREE,FOUR))
s1 = s.preprocess_prog.eval_prog([])
if not (s1.x1 == TWO and s1.y1 == THREE and s1.x2 == SIX and s1.y2 == 9)
	puts "FAILED: Shift should shift e by dx and dy"
else
	puts "Shift shifts e by dx and dy"
end

s = Shift.new(FIVE,-ONE,LineSegment.new(ONE,TWO,THREE,FOUR))
s1 = s.preprocess_prog.eval_prog([])
if (s1.x1 == SIX and s1.y1 == ONE and s1.x2 == EIGHT and s1.y2 == THREE)
    puts "Shift of line segment is working properly"
else 
    puts "FAILED: Shift of line segment is not working properly"
end

# Intersects tests
i = Intersect.new(LineSegment.new(1.0,5.0,2.0,7.0), LineSegment.new(2.0,4.0,3.0,6.0))
i1 = i.preprocess_prog.eval_prog([])
if i1.is_a? NoPoints
    puts "Intersect working for line segments that don't intersect"
else
    puts "FAILED: Intersect not working for line segments that don't intersect"
end
i = Intersect.new(LineSegment.new(1.0,5.0,2.0,7.0),LineSegment.new(1.0,5.0,2.0,7.0))
i1 = i.preprocess_prog.eval_prog([])
if i1.x1 == ONE and i1.y1 == FIVE and i1.x2 == TWO and i1.y2 == SEVEN
    puts "Intersect working for line segments that are the same"
else
    puts "FAILED: Intersect not working for line segments are the same"
end
i = Intersect.new(LineSegment.new(1.0,5.0,2.0,7.0),LineSegment.new(2.0,7.0,3.0,7.0))
i1 = i.preprocess_prog.eval_prog([])
if i1.x == TWO and i1.y == SEVEN
    puts "Intersect working for line segments that are connected"
else
    puts "FAILED: Intersect not working for line segments are connected"
end
i = Intersect.new(LineSegment.new(1.0,2.0,3.0,2.0),LineSegment.new(1.0,1.0,3.0,3.0))
i1 = i.preprocess_prog.eval_prog([])
if i1.x == TWO and i1.y == TWO 
    puts "Intersect working for line segments that cross"
else
    puts "FAILED: Intersect not working for line segments that cross"
end
i = Intersect.new(LineSegment.new(1.0,1.0,3.0,3.0), LineSegment.new(1.0,2.0,3.0,2.0))
i1 = i.preprocess_prog.eval_prog([])
if i1.x == TWO and i1.y == TWO 
    puts "Intersect working for line segments that cross (switched)"
else
    puts "FAILED: Intersect not working for line segments that cross (switched)"
end
i = Intersect.new(LineSegment.new(1.0,1.0,3.0,3.0), Point.new(2.0,2.0))
i1 = i.preprocess_prog.eval_prog([])
if i1.x == TWO and i1.y == TWO 
    puts "Intersect working for line segments and points"
else
    puts "FAILED: Intersect not working for line segments and points"
end
i = Intersect.new(Point.new(2.0,2.0), LineSegment.new(1.0,1.0,3.0,3.0) )
i1 = i.preprocess_prog.eval_prog([])
if i1.x == TWO and i1.y == TWO 
    puts "Intersect working for line segments and points (switched)"
else
    puts "FAILED: Intersect not working for line segments and points (switched)"
end
i = Intersect.new(Point.new(3.0,2.0), LineSegment.new(1.0,1.0,3.0,3.0) )
i1 = i.preprocess_prog.eval_prog([])
if i1.is_a? NoPoints 
    puts "Intersect working for line segments and points (nopoints)"
else
    puts "FAILED: Intersect not working for line segments and points (nopoints)"
end
i = Intersect.new(LineSegment.new(1.0,1.0,3.0,3.0), VerticalLine.new(2.0))
i1 = i.preprocess_prog.eval_prog([])
if i1.x == TWO and i1.y == TWO 
    puts "Intersect working for line segments and vertical line"
else
    puts "FAILED: Intersect not working for line segments and vertical line"
end
i = Intersect.new(VerticalLine.new(2.0), LineSegment.new(1.0,1.0,3.0,3.0) )
i1 = i.preprocess_prog.eval_prog([])
if i1.x == TWO and i1.y == TWO 
    puts "Intersect working for line segments and vertical line (switched)"
else
    puts "FAILED: Intersect not working for line segments and vertical line (switched)"
end
i = Intersect.new(VerticalLine.new(4.0), LineSegment.new(1.0,1.0,3.0,3.0) )
i1 = i.preprocess_prog.eval_prog([])
if i1.is_a? NoPoints 
    puts "Intersect working for line segments and vline (nopoints)"
else
    puts "FAILED: Intersect not working for line segments and vline (nopoints)"
end
i = Intersect.new(VerticalLine.new(2.0), LineSegment.new(1.0,2.0,2.0,2.0) )
i1 = i.preprocess_prog.eval_prog([])
if i1.x == TWO and i1.y == TWO 
    puts "Intersect working for line segments and vertical line (touching)"
else
    puts "FAILED: Intersect not working for line segments and vertical line (touching)"
end
i = Intersect.new(VerticalLine.new(2.0), Point.new(2.0,2.0) )
i1 = i.preprocess_prog.eval_prog([])
if i1.x == TWO and i1.y == TWO 
    puts "Intersect working for point and vertical line (touching)"
else
    puts "FAILED: Intersect not working for point and vertical line (touching)"
end
i = Intersect.new(Point.new(2.0,2.0), VerticalLine.new(2.0)  )
i1 = i.preprocess_prog.eval_prog([])
if i1.x == TWO and i1.y == TWO 
    puts "Intersect working for point and vertical line (switched)"
else
    puts "FAILED: Intersect not working for point and vertical line (switched)"
end
i = Intersect.new(VerticalLine.new(2.0), Point.new(3.0,2.0) )
i1 = i.preprocess_prog.eval_prog([])
if i1.is_a? NoPoints 
    puts "Intersect working for points and vline (nopoints)"
else
    puts "FAILED: Intersect not working for points and vline (nopoints)"
end

