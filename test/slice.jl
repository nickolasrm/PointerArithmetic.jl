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
end