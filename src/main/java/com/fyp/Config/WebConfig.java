package com.fyp.Config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
@EnableWebMvc
public class WebConfig extends WebMvcConfigurerAdapter {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry){
        registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
        registry.addResourceHandler("/app/**").addResourceLocations("classpath:/static/app/");
        registry.addResourceHandler("/css/**").addResourceLocations("classpath:/static/css/");
        registry.addResourceHandler("/js/**").addResourceLocations("classpath:/static/js/");
        registry.addResourceHandler("/img/**").addResourceLocations("classpath:/static/img/");
        registry.addResourceHandler("/video/**").addResourceLocations("classpath:/static/video/");
        registry.addResourceHandler("/home/zhuoyan/Vra/images/**").addResourceLocations("file:/home/zhuoyan/Vra/images/");
        registry.addResourceHandler("/Users/zykhoh/Downloads/Vra/**").addResourceLocations("file:/Users/zykhoh/Downloads/Vra/");

    }

}