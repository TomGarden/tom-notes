在 Spring Framework 中进行国际化的过程通常包括配置、资源文件、`MessageSource` 和标签使用。下面将逐步讲解和提供一个简单的示例。

### 1. **配置 `MessageSource` 和 `LocaleResolver`**

首先，配置 `MessageSource` 以支持资源文件，同时配置 `LocaleResolver` 来确定用户的本地化信息。这通常在 Spring 的配置文件（比如 XML 或 Java 配置类）中完成。

```java
@Configuration
public class AppConfig implements WebMvcConfigurer {

    @Bean
    public MessageSource messageSource() {
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasename("classpath:messages/messages");
        messageSource.setDefaultEncoding("UTF-8");
        return messageSource;
    }

    @Bean
    public LocaleResolver localeResolver() {
        AcceptHeaderLocaleResolver localeResolver = new AcceptHeaderLocaleResolver();
        localeResolver.setDefaultLocale(Locale.US);
        return localeResolver;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
        localeChangeInterceptor.setParamName("lang");
        registry.addInterceptor(localeChangeInterceptor);
    }
}
```

在这个示例中，`messages/messages` 表示资源文件的基本名称是 `messages`，而不是 `messages_en_US` 或 `messages_fr_FR`。Spring 将自动根据当前的 `Locale` 来选择合适的资源文件。

### 2. **创建资源文件**

在 `src/main/resources` 目录下创建一个名为 `messages` 的文件夹，并在该文件夹中创建资源文件，如下：

- `messages_en_US.properties`:

```properties
greeting.message=Hello, {0}!
```

- `messages_fr_FR.properties`:

```properties
greeting.message=Bonjour, {0}!
```

### 3. **在控制器中使用 `MessageSource`**

在控制器中注入 `MessageSource`，并使用其 `getMessage` 方法获取本地化的消息。

```java
@Controller
@RequestMapping("/greet")
public class GreetingController {

    @Autowired
    private MessageSource messageSource;

    @GetMapping
    public String greet(Model model, @RequestParam(defaultValue = "World") String name, Locale locale) {
        String greetingMessage = messageSource.getMessage("greeting.message", new Object[]{name}, locale);
        model.addAttribute("greeting", greetingMessage);
        return "greet";
    }
}
```

### 4. **在视图中显示消息**

在视图中使用 `<spring:message>` 标签来显示本地化的消息。

```html
<!-- src/main/resources/templates/greet.html -->
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Greeting Page</title>
</head>
<body>
    <h1 th:text="${greeting}"></h1>
</body>
</html>
```

### 5. **在页面中切换语言**

你可以在页面中使用链接或按钮等方式切换语言，通过请求参数 `lang` 来设置新的 `Locale`。

```html
<a href="?lang=en">English</a> |
<a href="?lang=fr">Français</a>
```

或者使用按钮：

```html
<form action="#" th:action="@{/greet}" th:method="get">
    <select name="lang" onchange="this.form.submit()">
        <option value="en" th:selected="${#locale.language eq 'en'}">English</option>
        <option value="fr" th:selected="${#locale.language eq 'fr'}">Français</option>
    </select>
</form>
```

这样，用户可以通过点击链接或选择下拉菜单来切换语言，而你的应用程序将显示相应的国际化消息。

请注意，上述示例使用了 Thymeleaf 模板引擎来呈现 HTML 页面。如果你使用的是其他模板引擎，视图的语法可能会有所不同。