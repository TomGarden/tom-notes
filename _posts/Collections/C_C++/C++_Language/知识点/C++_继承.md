
1. https://www.cprogramming.com/tutorial/virtual_inheritance.html
2. https://zh.cppreference.com/w/cpp/language/derived_class
3. https://www.kdab.com/jsonify-with-nlohmann-json/
```c++
    template < typename ValueType,
               detail::enable_if_t < !detail::is_basic_json<ValueType>::value && detail::has_from_json<basic_json_t,ValueType>::value, int > = 0 >
    ValueType & get_to(ValueType& v) const noexcept(noexcept(
                JSONSerializer<ValueType>::from_json(std::declval<const basic_json_t&>(), v)))
    {
        JSONSerializer<ValueType>::from_json(*this, v);
        return v;
    }
```