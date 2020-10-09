package com.tests;
import org.junit.Assert;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.Test;
public class BrowserStackTutorials {
    @Test
    public void testAssertFunctions() {
        System.setProperty("webdriver.chrome.driver", "C:\\I2EWebsiteTest\\Driver\\chromedriver.exe");
        WebDriver driver = new ChromeDriver();
        driver.get("https://www.opesmount.in/grocerystore1");
        String ActualTitle = driver.getTitle();
        String ExpectedTitle = "Grocerystore";
        try {
            Assert.assertEquals(ExpectedTitle, ActualTitle);
            System.out.println("Assertion passed");
        } catch (AssertionError ae) {
            ae.printStackTrace();
        }
        driver.navigate().to("https://demoqa.com/");
        String url = driver.getCurrentUrl();
        Assert.assertEquals("https://demoqa.com/", url);
        if(driver.toString()== null){
            System.out.println("Driver is null");
        }
        driver.close();
        driver.quit();
    }
}