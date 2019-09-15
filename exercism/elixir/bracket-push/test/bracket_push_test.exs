defmodule BracketPushTest do
  use ExUnit.Case

  test "paired square brackets" do
    assert BracketPush.check_brackets("[]") == true
  end

  test "empty string" do
    assert BracketPush.check_brackets("") == true
  end

  test "unpaired brackets" do
    assert BracketPush.check_brackets("[[") == false
  end

  test "wrong ordered brackets" do
    assert BracketPush.check_brackets("}{") == false
  end

  test "wrong closing bracket" do
    assert BracketPush.check_brackets("{]") == false
  end

  test "paired with whitespace" do
    assert BracketPush.check_brackets("{ }") == true
  end

  test "simple nested brackets" do
    assert BracketPush.check_brackets("{[]}") == true
  end

  test "several paired brackets" do
    assert BracketPush.check_brackets("{}[]") == true
  end

  test "paired and nested brackets" do
    assert BracketPush.check_brackets("([{}({}[])])") == true
  end

  test "unopened closing brackets" do
    assert BracketPush.check_brackets("{[)][]}") == false
  end

  test "unpaired and nested brackets" do
    assert BracketPush.check_brackets("([{])") == false
  end

  test "paired and wrong nested brackets" do
    assert BracketPush.check_brackets("[({]})") == false
  end

  test "math expression" do
    assert BracketPush.check_brackets("(((185 + 223.85) * 15) - 543)/2") == true
  end

  test "complex latex expression" do
    assert BracketPush.check_brackets(
             "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)"
           ) == true
  end
end
