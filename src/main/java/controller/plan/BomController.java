package controller.plan;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import spring.plan.BomInfo;

@Controller
@RequestMapping("/bom")
public class BomController {
	
	@PostMapping("/show")
    @ResponseBody
    public Map<String, Object> testAjax(BomInfo bomInfo){
        
        Map<String, Object> result = new HashMap<String, Object>();
        

        System.out.println(bomInfo.getProdNo());
        System.out.println(bomInfo.getMaterNo());
 
        
        // 응답 데이터 셋팅
        result.put("a", "b");
        
        return result;
        
    }
	
	
}
