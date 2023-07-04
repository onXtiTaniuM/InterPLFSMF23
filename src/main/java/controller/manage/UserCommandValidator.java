package controller.manage;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class UserCommandValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return ManageUserCommand.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "id", "required");
		ValidationUtils.rejectIfEmpty(errors, "password", "required");
	}

}
