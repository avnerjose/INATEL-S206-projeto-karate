package projeto_karate.dummy_json;

import com.intuit.karate.junit5.Karate;

public class DummyJson {
    @Karate.Test
    Karate testDummyJson() {
        return Karate.run("dummy_json").relativeTo(getClass());
    }
}
