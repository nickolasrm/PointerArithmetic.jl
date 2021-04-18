@testset "Slice" begin
    a = [1,2,3,4]
    b = Slice(a, 2:4)
    @test b[1] == a[2]
    @test b[0] == a[1]
    b = b << -1    
    @test length(b) == 4
    @test b[1] == a[1]
    b = b >> -1
    @test length(b) == 3
    @test b[3] == a[3]
    @test b[4] == a[4]
    b[4] = 10000
    @test a[4] == 10000

    @test_broken Slice(a, 3:2)
    @test_broken Slice(a, 0:4)
    @test_broken Slice(a, 1:5)
    b = Slice(a, 2:3)
    @test_broken b << -2
    @test_broken b << 2
    @test_broken b >> 2
    @test_broken b >> -2

    @test_broken b[4]
    @test_broken b[-1]
    @test_broken b[4] = 2
    @test_broken b[-1] = 2
    
    @test size(b) == (2,)
    @test interval(b) == 2:3
    
    c = Slice(b, 1:3)
    @test length(c) == 3
    @test c[3] == 10000
    c = Slice(b, 1:1)
    @test length(c) == 1
    @test b[1] == 2
    c = Slice(b, 0:3)
    @test sum(c .== a) == length(c)
    @test_broken Slice(b, -1:3)
    @test_broken Slice(b, 0:4)
    @test_broken Slice(b, -1:4)

end