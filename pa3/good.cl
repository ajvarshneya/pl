class Main inherits IO {

	main() : Object {
		-- Lets
		let
			martin_freeman : Bilbo,
			ian_mckellen : Gandalf,
			richard_armitage : Thorin
		in
		let
			series : Hobbit
		in
		let
			one_book : Too_Many_Movies
		in { -- Blocks
			{
				{
					{
						{
							{
								{
									{
										{
											{
												{
													{
														{
													{ { {
													{ { {
			erebor;
													}; }; };
													}; }; };
													};
												};
											}; 
										}; 
									};
								}; 
							}; 
						}; 
					}; 
				}; 
			};};

			-- Case
			case character of
			burglar : Hobbit => ring = 1;
			gandlaf : Wizard => staff + hat;
			dwarf : Dwarf => case dwarf of durins_folk : Dwarf =>
						case durins_folk of leader : Royal =>
							case leader of thorin : King => thorin;
						esac;
					esac;
				esac;
			esac;

			-- Dispatch
			hobbits + hobbits
				@
				Isengard
				.
				taking
				(
					hobbits(
						taking(
							hobbits(
								isengard()))),
					hobbits(
						hobbits(
							isengard()))
				);
		}
	};
};