local template = [[
{greet!?Hi}, {name?world}!
]];
local expect1 = [[
Hello, WORLD!
]];
local expect2 = [[
Hello, world!
]];
local expect3 = [[
Hi, YOU!
]];
local template_array = [[
{foo#{idx}. {item}
}]]
local expect_array = [[
1. HELLO
2. WORLD
]]
local template_func_pipe = [[
{foo|sort#{idx}. {item}
}]]
local expect_func_pipe = [[
1. A
2. B
3. C
4. D
]]
local template_map = [[
{foo%{idx}: {item!}
}]]
local expect_map = [[
FOO: bar
]]

describe("util.interpolation", function ()
	it("renders", function ()
		local render = require "util.interpolation".new("%b{}", string.upper, { sort = function (t) table.sort(t) return t end });
		assert.equal(expect1, render(template, { greet = "Hello", name = "world" }));
		assert.equal(expect2, render(template, { greet = "Hello" }));
		assert.equal(expect3, render(template, { name = "you" }));
		assert.equal(expect_array, render(template_array, { foo = { "Hello", "World" } }));
		assert.equal(expect_func_pipe, render(template_func_pipe, { foo = { "c", "a", "d", "b", } }));
		-- assert.equal("", render(template_func_pipe, { foo = nil })); -- FIXME
		assert.equal(expect_map, render(template_map, { foo = { foo = "bar" } }));
	end);
end);
